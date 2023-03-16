variable "main" {
  default = {
    "region" = "us-east-1"
  }
}

variable "ec2" {
  default = {
    "AMI" = "ami-0557a15b87f6559cf"
    "ec2_type" = "t2.micro"
    "tag" = "Jenkins_capstone"
    }
  type = map
}

variable "network" {
  default = {
    "cidr_block" = "10.0.0.0/16"
    "AVAIL_ZONE_A" = "us-east-1a"
    "AVAIL_ZONE_B" = "us-east-1b"
  }
  type = map
}
