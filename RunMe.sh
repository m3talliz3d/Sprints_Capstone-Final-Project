#!/bin/bash
# Script is not complete, please avoid using it.

source scripts/config_ssh_modification.sh
source scripts/infra_deployment.sh

export CAPSTONE_PROJECT=$PWD
echo $CAPSTONE_PROJECT
hello_world
#create_include_config_ssh
#sleep 5
#remove_include_config_ssh
#terraform_deploy
#terraform_destroy
#create_config_file 2>/dev/null && chmod 600 creds/config


EXIT=0
while [ $EXIT -ne 1 ]
do
  echo "Choose one of the options to run the capstone project:"

  echo "1 - Run Prepare Credentials directory"
  echo "2 - Run Terrafrom then Run Playbook Ansible"
  echo "3 - Run Terrafrom Only"
  echo "4 - Run Ansible Playbook Only"
  echo "5 - Detroy Terraform (no-confirmation)"
  echo "6 - Cleanup"
  echo "0 - Exit"

  read num
  case $num in
  0) EXIT=1 ;;
  1)hello_world;;
  2) ;;
  3) ;;
  4) ;;
  5) ;;
  6) ;;
  *)echo "You have chosen unidentified number"
  esac
done