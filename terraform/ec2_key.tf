resource "tls_private_key" "ansible_keypair" {
  algorithm   = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2_keypair" {
  key_name = "ec2_keypair"
  public_key = tls_private_key.ansible_keypair.public_key_openssh
  depends_on = [ tls_private_key.ansible_keypair ]
}

output "private_key_pem" {
  value = tls_private_key.ansible_keypair.private_key_pem
  sensitive = true
  depends_on = [ aws_key_pair.ec2_keypair ]
}