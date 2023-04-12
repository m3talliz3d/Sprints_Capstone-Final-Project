#!/bin/bash
# Script is not complete, please avoid using it.

set -eu

source scripts/config_ssh_modification.sh
source scripts/infra_deployment.sh
source scripts/echo_scripts.sh
source scripts/cleanup.sh

export CAPSTONE_PROJECT=$PWD
#echo $CAPSTONE_PROJECT

clear
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

  1)
  mkdir -p creds
  # Script: config_ssh_modification
  create_config_file 2>/dev/null && chmod 600 creds/config
  create_include_config_ssh;;

  2)
  # Script: infra_deployment
  terraform_deploy
  ansible_deploy
  clear
  # script: echo_scripts
  echo_terraform_deploy
  echo_ansible_ansible
  ;;

  3)
  # Script: infra_deployment
  terraform_deploy
  # Script: config_ssh_modification
  create_pem_file
  clear
  # script: echo_scripts
  echo_terraform_deploy
  break;;

  4)
  # Script: infra_deployment
  ansible_deploy
  # script: echo_scripts
  echo_ansible_ansible
  break;;

  5)
  # Script: infra_deployment
  terraform_destroy
  clear
  # script: echo_scripts
  echo_terraform_destroy
  ;;

  6) 
  remove_include_config_ssh;;

  q)
  EXIT=1
  echo "Exiting..."
  sleep 3;;

  *)
  echo "You have chosen unidentified number, try again..."
  esac
done