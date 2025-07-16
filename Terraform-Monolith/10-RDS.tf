# RDS 서브넷 그룹 생성
resource "aws_db_subnet_group" "MSA_rds_subnet_group" {
  name       = "msa_rds_subnet_group"
  subnet_ids = [aws_subnet.MSA_pri_subnet_2a.id, aws_subnet.MSA_pri_subnet_2c.id]

  tags = {
    Name = "MSA_rds_subnet_group"
  }
}

# MariaDB Parameter Group 설정
resource "aws_db_parameter_group" "MSA_mariadb_parameter_group" {
  name        = "msa-mariadb-parameter-group"
  family      = "mariadb10.11" # 사용 중인 MariaDB 버전에 맞게 조정
  description = "Custom parameter group for MariaDB"

  parameter {
    name  = "max_connections"
    value = "150"
  }

  parameter {
    name  = "time_zone"
    value = "Asia/Seoul"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_connection"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_filesystem"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_results"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }

  parameter {
    name  = "collation_connection"
    value = "utf8mb4_unicode_ci"
  }

  parameter {
    name  = "collation_server"
    value = "utf8mb4_unicode_ci"
  }


  parameter {
    name  = "binlog_format"
    value = "ROW"
  }
}

# RDS 생성
resource "aws_db_instance" "MSA_mariadb_rds" {
  identifier_prefix    = "MSA_mariadb_rds"
  allocated_storage    = 10
  engine               = "mariadb"
  engine_version       = "10.11.8"
  instance_class       = "db.t3.micro"
  db_name              = "MSA_mariadb_rds" # 영문자로 시작해야 하며 영문자와 숫자, _만 가능
  username             = "MSA_User"
  password             = "P@ssw0rd" # 8자 이상, 영문 대소문자, 숫자 및 특수 문자를 혼합하여 사용
  parameter_group_name = "MSA_mariadb_parameter_group"
  skip_final_snapshot  = true
  #multi_az               = true
  db_subnet_group_name   = aws_db_subnet_group.MSA_rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.MSA_sg_rds.id]

  tags = {
    Name = "MSA_mariadb_rds"
  }
}