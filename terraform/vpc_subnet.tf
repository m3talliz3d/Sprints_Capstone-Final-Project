# Create a VPC
resource "aws_vpc" "vpc_capstone" {
  cidr_block = "10.0.0.0/16"

  tags = {
    "Name" = "vpc_sprints_capstone"
  }
}

resource "aws_subnet" "subnet_capstone" {
  vpc_id = aws_vpc.vpc_capstone.id
  cidr_block = "10.0.20.0/24"
}