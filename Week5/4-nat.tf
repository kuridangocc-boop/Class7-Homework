resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "terraform-eip-for-nat"
  }
  depends_on = [aws_internet_gateway.main] # explicit dependency
}

resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.nat.id # implicit dependency for eip
  subnet_id     = aws_subnet.public_a.id

  tags = {
    Name = "terraform-nat-gw"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.main]
}