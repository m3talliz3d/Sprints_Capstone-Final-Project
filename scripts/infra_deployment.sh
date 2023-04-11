#!/bin/bash

terraform_deploy(){
  terraform -chdir=terraform/ apply
}

terraform_destroy(){
  terraform -chdir=terraform/ destroy --auto-approve
}