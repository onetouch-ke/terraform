resource "aws_security_group" "Monolith_sg_rds" {
  name        = "Monolith_sg_rds"
  description = "for Bastion Server"
  vpc_id      = aws_vpc.Monolith_vpc.id
  tags = {
    "Name" = "Monolith_sg_rds"
  }
  
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "for DB"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}