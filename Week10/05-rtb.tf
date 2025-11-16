resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.main.id
  # default gateway route
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "terraform-public-rtb"
  }
}

########################### Public RTB #########################
# Please note that one of either subnet_id or gateway_id is required.
# remember to provide ".id" for all ids.

resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public_rtb.id
}
resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public_rtb.id
}
resource "aws_route_table_association" "public_c" {
  subnet_id      = aws_subnet.public_c.id
  route_table_id = aws_route_table.public_rtb.id
}
########################### Private RTB #########################
resource "aws_route_table" "private_rtb" {
  vpc_id = aws_vpc.main.id
  # default gateway route
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.example.id # for private, this needs to be the NAT GW.
  }

  tags = {
    Name = "terraform-private-rtb"
  }
}

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private_rtb.id
}
resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private_rtb.id
}
resource "aws_route_table_association" "private_c" {
  subnet_id      = aws_subnet.private_c.id
  route_table_id = aws_route_table.private_rtb.id
}
# class notes 
# items in between "{}" are called configuration objects.  = sign is for specific items
# Make Internet Gateway before NAT Gateway. 