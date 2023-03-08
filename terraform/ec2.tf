resource "aws_instance" "instance_capstone_jenkins" {
  ami = "ami-0557a15b87f6559cf"
  instance_type = "t2.micro"
  key_name = "ansible-keypair"
  subnet_id = aws_subnet.subnet_capstone.id
  vpc_security_group_ids = [
    "${aws_security_group.sg_capstone.id}"
  ]

lifecycle {
  create_before_destroy = true
}

  tags = {
    "Name" = "Jenkins_capstone"
  }
}

output "public_ip" {
  value = aws_instance.instance_capstone_jenkins.public_ip
}