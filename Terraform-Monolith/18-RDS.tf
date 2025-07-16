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

  # ✅ 자동 백업 설정
  backup_retention_period = 7             # 최대 35일까지 가능
  preferred_backup_window = "10:00-11:00" # UTC 기준

  deletion_protection = false

  tags = {
    Name = "monolith-rds"
  }
}
