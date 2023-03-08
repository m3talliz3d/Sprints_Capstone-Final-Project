resource "aws_instance" "instance_capstone_jenkins" {
  ami = "ami-006dcf34c09e50022"
  instance_type = "t2.micro"
  key_name = "ansible-keypair.pem"
  subnet_id = aws_subnet.subnet_capstone.id
}