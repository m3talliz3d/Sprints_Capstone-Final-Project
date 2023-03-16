# Create a VPC
resource "aws_vpc" "vpc_capstone" {
  cidr_block = var.network["cidr_block"]

  tags = {
    "Name" = "vpc_sprints_capstone"
  }
}

resource "aws_subnet" "subnet_public_capstone_A" {
  vpc_id = aws_vpc.vpc_capstone.id
  cidr_block = "10.0.20.0/24"
  map_public_ip_on_launch = true
  availability_zone = var.network["AVAIL_ZONE_A"]

  tags = {
    "Name" = "subnet_public_capstone_A"
  }
}

resource "aws_subnet" "subnet_public_capstone_B" {
  vpc_id = aws_vpc.vpc_capstone.id
  cidr_block = "10.0.25.0/24"
  map_public_ip_on_launch = true
  availability_zone = var.network["AVAIL_ZONE_B"]


  tags = {
    "Name" = "subnet_public_capstone_B"
  }
}