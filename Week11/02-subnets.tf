resource "aws_subnet" "public_a" {
  vpc_id = aws_vpc.main.id # get VPC ID and add it here
  # step 1: make VPC
  # step 2: get VPC ID
  # step 3: add VPC ID into vpc_id argument in theis subnet
  # which VPC to create subnet in

  cidr_block              = "10.155.1.0/24"
  availability_zone       = "us-east-1a" # specify AZ
  map_public_ip_on_launch = true         # added because default is false.  it allows public IPs to be 

  tags = {
    Name = "public-subnet-us-east-1a"
  }
}
resource "aws_subnet" "public_b" {
  vpc_id = aws_vpc.main.id # get VPC ID and add it here
  # step 1: make VPC
  # step 2: get VPC ID
  # step 3: add VPC ID into vpc_id argument in theis subnet
  # which VPC to create subnet in

  cidr_block              = "10.155.2.0/24"
  availability_zone       = "us-east-1b" # specify AZ
  map_public_ip_on_launch = true         # added because default is false.  it allows public IPs to be 

  tags = {
    Name = "public-subnet-us-east-1b"
  }
}
resource "aws_subnet" "public_c" {
  vpc_id = aws_vpc.main.id # get VPC ID and add it herb
  # step 1: make VPC
  # step 2: get VPC ID
  # step 3: add VPC ID into vpc_id argument in theis subnet
  # which VPC to create subnet in

  cidr_block              = "10.155.3.0/24"
  availability_zone       = "us-east-1c" # specify AZ
  map_public_ip_on_launch = true         # added because default is false.  it allows public IPs to be 
  tags = {
    Name = "public-subnet-us-east-1c"
  }
}
########################### Private Subnets #########################
resource "aws_subnet" "private_a" {
  vpc_id = aws_vpc.main.id # get VPC ID and add it here
  # step 1: make VPC
  # step 2: get VPC ID
  # step 3: add VPC ID into vpc_id argument in theis subnet
  # which VPC to create subnet in

  cidr_block              = "10.155.11.0/24"
  availability_zone       = "us-east-1a" # specify AZ
  map_public_ip_on_launch = false        # private subnet does not require public IP

  tags = {
    Name = "private-subnet-us-east-1a"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id = aws_vpc.main.id # get VPC ID and add it here
  # step 1: make VPC
  # step 2: get VPC ID
  # step 3: add VPC ID into vpc_id argument in theis subnet
  # which VPC to create subnet in

  cidr_block              = "10.155.12.0/24"
  availability_zone       = "us-east-1b" # specify AZ
  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-us-east-1b"
  }
}

resource "aws_subnet" "private_c" {
  vpc_id = aws_vpc.main.id # get VPC ID and add it here
  # step 1: make VPC
  # step 2: get VPC ID
  # step 3: add VPC ID into vpc_id argument in theis subnet
  # which VPC to create subnet in

  cidr_block              = "10.155.13.0/24"
  availability_zone       = "us-east-1c" # specify AZ
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet-us-east-1c"
  }
}



