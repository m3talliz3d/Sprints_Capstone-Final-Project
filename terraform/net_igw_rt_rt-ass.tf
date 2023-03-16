resource "aws_internet_gateway" "igw_capstone" {
  vpc_id = aws_vpc.vpc_capstone.id

  tags = {
    "Name" = "igw_capstone"
  }
}

resource "aws_route_table" "rt_public_capstone" {
  vpc_id = aws_vpc.vpc_capstone.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_capstone.id
  }

  tags = {
    "Name" = "rt_public_capstone"
  }
}

resource "aws_route_table" "rt_private_capstone" {
  vpc_id = aws_vpc.vpc_capstone.id

  route {
    cidr_block = "10.0.21.0/24"
    #gateway_id = aws_internet_gateway.igw_capstone.id
  }

  tags = {
    "Name" = "rt_private_capstone"
  }
}

resource "aws_route_table_association" "rt-ass_public_capstone" {
  subnet_id = aws_subnet.subnet_public_capstone.id
  route_table_id = aws_route_table.rt_public_capstone.id
}

resource "aws_route_table_association" "rt-ass_private_capstone" {
  subnet_id = aws_subnet.subnet_private_capstone.id
  route_table_id = aws_route_table.rt_private_capstone.id
}