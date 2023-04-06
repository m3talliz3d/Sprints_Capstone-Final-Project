terraform {
  required_providers {
    #AWS_Provider
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    #TLS_Provider
    tls = {
      source = "hashicorp/tls"
      version = "4.0.4"
    }
  }
}



# Configure the AWS Provider
provider "aws" {
  region = var.main["region"]
  access_key = "${jsondecode(file("../creds/aws_creds")).AWS_ACCESS_KEY_ID}"
  secret_key = "${jsondecode(file("../creds/aws_creds")).AWS_SECRET_ACCESS_KEY}"
}