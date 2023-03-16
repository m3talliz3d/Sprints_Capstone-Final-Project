resource "aws_instance" "instance_capstone_jenkins" {
  ami = var.ec2["AMI"]
  instance_type = var.ec2["ec2_type"]
  key_name = "ansible-keypair"
  subnet_id = aws_subnet.subnet_public_capstone.id
  vpc_security_group_ids = [
    "${aws_security_group.sg_capstone.id}"
  ]

lifecycle {
  create_before_destroy = true
}

  tags = {
    "Name" = var.ec2["tag"]
  }
}

output "public_ip" {
  value = aws_instance.instance_capstone_jenkins.public_ip
}