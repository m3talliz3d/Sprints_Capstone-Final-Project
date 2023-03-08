resource "aws_security_group" "sg_capstone" {
  name_prefix = "sg_capstone_22_8080"
  vpc_id = aws_vpc.vpc_capstone.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/24"]
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/24"]
  }

  tags = {
    "Name" = "sg_capstone_22_8080"
  }
}