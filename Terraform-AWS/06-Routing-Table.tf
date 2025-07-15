# 라우팅 테이블
resource "aws_route_table" "terraform_pub_rt" {
  vpc_id = aws_vpc.terraform_vpc.id

  tags = {
    "Name" = "terraform_pub_rt"
  }
}

resource "aws_route_table" "terraform_pri_rt" {
  vpc_id = aws_vpc.terraform_vpc.id

  tags = {
    "Name" = "terraform_pri_rt"
  }
}

# 라우팅
resource "aws_route" "terraform_pub_rt" {
  route_table_id         = aws_route_table.terraform_pub_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.terraform_igw.id
}

resource "aws_route" "terraform_pri_rt" {
  route_table_id         = aws_route_table.terraform_pri_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.terraform_ngw.id
}

# 명시적 서브넷 연결
resource "aws_route_table_association" "terraform_pub_rt_associate_2a" {
  subnet_id      = aws_subnet.terraform_pub_subnet_2a.id
  route_table_id = aws_route_table.terraform_pub_rt.id
}

resource "aws_route_table_association" "terraform_pub_rt_associate_2c" {
  subnet_id      = aws_subnet.terraform_pub_subnet_2c.id
  route_table_id = aws_route_table.terraform_pub_rt.id
}

resource "aws_route_table_association" "terraform_pri_rt_associate_2a" {
  subnet_id      = aws_subnet.terraform_pri_subnet_2a.id
  route_table_id = aws_route_table.terraform_pri_rt.id
}

resource "aws_route_table_association" "terraform_pri_rt_associate_2c" {
  subnet_id      = aws_subnet.terraform_pri_subnet_2c.id
  route_table_id = aws_route_table.terraform_pri_rt.id
}