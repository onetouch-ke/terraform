resource "aws_internet_gateway" "Monolith_igw" {
  vpc_id = aws_vpc.Monolith_vpc.id

  tags = {
    Name = "Monolith_igw"  # AWS 태그 값은 하이픈 OK
  }
}