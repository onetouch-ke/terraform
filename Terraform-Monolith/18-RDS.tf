##########################
# 1. DB Subnet Group
##########################

resource "aws_db_subnet_group" "monolith_rds_subnet_group" {
  name = "monolith-rds-subnet-group"
  subnet_ids = [
    aws_subnet.Monolith_pri_subnet_2a.id,
    aws_subnet.Monolith_pri_subnet_2c.id
  ]

  tags = {
    Name = "monolith-rds-subnet-group"
  }
}

##########################
# 2. Security Group for RDS
##########################

resource "aws_security_group" "monolith_rds_sg" {
  name        = "monolith-rds-sg"
  description = "Allow MySQL access"
  vpc_id      = aws_vpc.Monolith_vpc.id

  ingress {
    description = "MySQL"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # 개발용 설정: 운영에서는 제한 필요
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "monolith-rds-sg"
  }
}

##########################
# 3. RDS Instance (MySQL)
##########################

resource "aws_db_instance" "monolith_db" {
  identifier             = "monolith-db"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  db_name                = "monolith"
  username               = "admin"
  password               = "Password123!" # 실제 운영에서는 secret으로 관리 권장
  skip_final_snapshot    = true
  publicly_accessible    = true
  db_subnet_group_name   = aws_db_subnet_group.monolith_rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.monolith_rds_sg.id]

  tags = {
    Name = "monolith-db"
  }

  depends_on = [aws_db_subnet_group.monolith_rds_subnet_group]
}

##########################
# 4. S3 Bucket for Backup
##########################

resource "aws_s3_bucket" "rds_backup_bucket" {
  bucket = "monolith-rds-backup-${random_id.suffix.hex}"

  tags = {
    Name = "monolith-rds-backup"
  }
}

resource "random_id" "suffix" {
  byte_length = 4
}
