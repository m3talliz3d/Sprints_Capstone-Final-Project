resource "aws_internet_gateway" "igw_capstone" {
  vpc_id = aws_vpc.vpc_capstone.id
}

resource "aws_route_table" "rt_capstone" {
  vpc_id = aws_vpc.vpc_capstone.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_capstone.id
  }
}

resource "aws_route_table_association" "rt-ass_capstone" {
  subnet_id = aws_subnet.subnet_capstone.id
  route_table_id = aws_route_table.rt_capstone.id
}

