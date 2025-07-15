resource "aws_instance" "Monolith_pub_ec2_bastion_2a" {
  ami                         = "ami-056a29f2eddc40520"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.Monolith_sg_bastion.id]
  subnet_id                   = aws_subnet.Monolith_pub_subnet_2a.id
  key_name                    = "tg-01"
  associate_public_ip_address = true

  root_block_device {
    volume_size = "8"
    volume_type = "gp2"
    tags = {
      "Name" = "Monolith_pub_ec2_bastion_2a"
    }
  }

  tags = {
    "Name" = "Monolith_pub_ec2_bastion_2a"
  }
}