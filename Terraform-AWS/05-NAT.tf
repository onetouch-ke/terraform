# 탄력적(Elastic) IP
resource "aws_eip" "terraform_eip" {
  domain = "vpc"
}

# NAT 게이트웨이
resource "aws_nat_gateway" "terraform_ngw" {
  allocation_id = aws_eip.terraform_eip.id
  subnet_id     = aws_subnet.terraform_pub_subnet_2a.id
  tags = {
    "Name" = "terraform_ngw"
  }
}