resource "aws_instance" "instance_capstone_jenkins" {
  ami = var.ec2["AMI"]
  instance_type = var.ec2["ec2_type"]
  #key_name = "ansible-keypair"
  subnet_id = aws_subnet.subnet_public_capstone_A.id
  vpc_security_group_ids = ["${aws_security_group.sg_capstone.id}"]
  key_name = aws_key_pair.ec2_keypair.key_name
  user_data = "${file("../scripts/ansible_dock_aws_kube.sh")}"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    "Name" = var.ec2["tag"]
  }
  depends_on = [aws_key_pair.ec2_keypair]
}

resource "null_resource" "public_ip_to_etc_hosts" {
  # provisioner "local-exec" {
  #   command = "PUBLIC_IP=${aws_instance.instance_capstone_jenkins.public_ip}"
  # }
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
  depends_on = [aws_instance.instance_capstone_jenkins]
}