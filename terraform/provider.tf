terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  access_key = "${jsondecode(file("../creds/aws_creds")).AWS_ACCESS_KEY_ID}"
  secret_key = "${jsondecode(file("../creds/aws_creds")).AWS_SECRET_ACCESS_KEY}"
}