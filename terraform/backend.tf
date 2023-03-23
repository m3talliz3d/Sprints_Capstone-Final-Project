terraform {
  backend "s3" {
    bucket = "sprints-s3-tf-state"
    key = "terraform.tfstate"
    region = "us-east-1"
  }
}