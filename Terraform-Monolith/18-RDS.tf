# RDS Subnet Group (Private Subnet 2a, 2c 사용)
resource "aws_db_subnet_group" "monolith_db_subnet_group" {
  name = "monolith-db-subnet-group"
  subnet_ids = [
    aws_subnet.Monolith_pri_subnet_2a.id,
    aws_subnet.Monolith_pri_subnet_2c.id
  ]

  tags = {
    Name = "monolith-db-subnet-group"
  }
}

# RDS Security Group
resource "aws_security_group" "monolith_rds_sg" {
  name   = "monolith-rds-sg"
  vpc_id = aws_vpc.Monolith_vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # ✅ 테스트용 — 운영 시 제한 권장
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

# RDS 인스턴스
resource "aws_db_instance" "monolith_rds" {
  identifier             = "monolith-db"
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  db_name                = "monolith"
  username               = "admin"
  password               = "Admin1234!"
  skip_final_snapshot    = false
  publicly_accessible    = true
  db_subnet_group_name   = aws_db_subnet_group.monolith_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.monolith_rds_sg.id]

  # 자동 백업 설정 (UTC 기준 → KST 오후 7시 → UTC 오전 10시)
  backup_retention_period = 7
  #   preferred_backup_window = "10:00-11:00"

  deletion_protection = false

  tags = {
    Name = "monolith-rds"
  }
}
