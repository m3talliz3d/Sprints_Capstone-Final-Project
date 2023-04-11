#!/bin/bash
# Script is not complete, please avoid using it.

source scripts/config_ssh_modification.sh
source scripts/infra_deployment.sh

export CAPSTONE_PROJECT=$PWD
echo $CAPSTONE_PROJECT
hello_world
#sleep 5


EXIT=0
while [ $EXIT -ne 1 ]
do
  echo "Choose one of the options to run the capstone project: (q to quit)"

  echo "1 - Prepare Credentials directory"
  echo "2 - Run Terrafrom then Run Playbook Ansible"
  echo "3 - Run Terrafrom Only"
  echo "4 - Run Ansible Playbook Only"
  echo "5 - Detroy Terraform (no-confirmation)"
  echo "6 - Cleanup"
  echo "q - Exit"

  read num
  case $num in

  q) EXIT=1
    echo "Exiting..."
    sleep 3;;
  1)
  mkdir -p creds
  create_config_file 2>/dev/null && chmod 600 creds/config
  echo "test";;
  2) ;;
  3) terraform_deploy
  create_pem_file
  clear
  echo "##################################"
  echo "Terrafrom Deployment is successful"
  echo "##################################"
  break;;
  4) ;;
  5) terraform_destroy;;
  6) ;;
  *)echo "You have chosen unidentified number, try again..."
  esac
done