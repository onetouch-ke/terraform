resource "aws_db_instance" "monolith_rds" {
  identifier             = "monolith-db"
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  username               = "admin"
  password               = "yourpassword"
  db_name                = "monolith"
  skip_final_snapshot    = false
  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.Monolith_sg_eks_node_group.id]
  availability_zone      = "ap-northeast-2a"

  backup_retention_period = 7
}
