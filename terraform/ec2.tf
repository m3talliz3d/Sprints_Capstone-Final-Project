resource "aws_instance" "instance_capstone_jenkins" {
  ami = var.ec2["AMI"]
  instance_type = var.ec2["ec2_type"]
  key_name = "ansible-keypair"
  subnet_id = aws_subnet.subnet_public_capstone_A.id
  vpc_security_group_ids = ["${aws_security_group.sg_capstone.id}"]

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = var.ec2["tag"]
  }
}

resource "null_resource" "public_ip_to_etc_hosts" {
  provisioner "local-exec" {
    command = "../scripts/ec2_public_ip_add.sh"
  }
  provisioner "local-exec" {
    when = destroy
    command = "../scripts/ec2_public_ip_remove.sh"
  }
  depends_on = [aws_instance.instance_capstone_jenkins]
}

output "public_ip" {
  value = aws_instance.instance_capstone_jenkins.public_ip
}