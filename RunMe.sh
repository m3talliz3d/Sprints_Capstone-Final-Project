#!/bin/bash

set -eu

############ SCRIPT CHECKSUM VERIFICATION START ####################
declare -A scripts_checksum=(
["scripts/ec2_public_ip_add.sh"]="scripts/ec2_public_ip_add.sh.checksum"
["scripts/ec2_public_ip_remove.sh"]="scripts/ec2_public_ip_remove.sh.checksum"
["scripts/ansible_dock_aws_kube.sh"]="scripts/ansible_dock_aws_kube.sh.checksum"
["scripts/config_ssh_modification.sh"]="scripts/config_ssh_modification.sh.checksum"
["scripts/infra_deployment.sh"]="scripts/infra_deployment.sh.checksum"
["scripts/echo_scripts.sh"]="scripts/echo_scripts.sh.checksum"
["scripts/cleanup.sh"]="scripts/cleanup.sh.checksum"
["scripts/templates.sh"]="scripts/templates.sh.checksum"
["scripts/jenkins_p1_main.sh"]="scripts/jenkins_p1_main.sh.checksum"
["scripts/jenkins_p2_PassGen.sh"]="scripts/jenkins_p2_PassGen.sh.checksum"
)

for script in "${!scripts_checksum[@]}"; do
  checksum_generated=$(sha256sum $script | cut -d ' ' -f1)
  #echo "generated $checksum_generated"
  checksum_expected=$(cat ${scripts_checksum[$script]})
  #echo "expected  $checksum_expected"
  if [ $checksum_generated != $checksum_expected ]; then
    echo -e "######################################\nERROR: $script has been modified"
    echo -e "Please verify that your $HOSTNAME is secure\n######################################\n"
    echo -e "Note: To remove the security check\nYou can remove 'SCRIPT CHECKSUM VERIFICATION' section\nTo bypass check, yet it is not recommended."
    exit 1
  fi
done
echo -e "\n######################################\nSUCCESS: Scripts has not been modified\n######################################\n"
sleep 2
############ SCRIPT CHECKSUM VERIFICATION END ####################

source scripts/config_ssh_modification.sh
source scripts/infra_deployment.sh
source scripts/echo_scripts.sh
source scripts/cleanup.sh
source scripts/templates.sh
source scripts/jenkins_p1_main.sh

export CAPSTONE_PROJECT=$PWD


EXIT=0
while [ $EXIT -ne 1 ]
do
  echo "Choose one of the options to run the capstone project: (q to quit)"

  echo "1 - Prepare Credentials directory"
  echo "             --------            "
  echo "2 - Run Terrafrom then Run Playbook Ansible"
  echo "             --------            "
  echo "3 - Run Terrafrom Only"
  echo "4 - Run Ansible Playbook Only"
  echo "             --------            "
  echo "5 - SSH to the deployed EC2 instance (Will work Soon..)"
  echo "6 - Push credentials to Jenkins"
  echo "             --------            "
  echo "7 - Destroy Infrastructure (no-confirmation)"
  echo "8 - Cleaup"
  echo "q - Exit"

  read num
  case $num in

  1)
  mkdir -p creds
  # Script: config_ssh_modification
  create_config_file 2>/dev/null && chmod 600 creds/config
  create_include_config_ssh
  create_aws_creds;;

  2)
  # Script: infra_deployment
  echo "Deploying Infrastructure..."
  terraform_deploy
  create_pem_file
  echo "Preparing ssh config in 15s"
  sleep 15
  echo "pushing Ansible configuration to EC2..."
  ansible_deploy
  clear
  # script: echo_scripts
  echo_terraform_deploy
  echo_ansible_ansible
  break;;

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
  ;;

  6)
  jenkins_password
  break;;

  7)
  # Script: infra_deployment
  terraform_destroy
  clear
  # script: echo_scripts
  echo_terraform_destroy
  break;;
  
  8)
  remove_include_config_ssh
  echo_remove_include_config_ssh
  delete_creds_dir
  echo_delete_creds_dir
  break;;
  
  q)
  EXIT=1
  echo "Exiting..."
  sleep 3;;

  *)
  echo "You have chosen unidentified number, try again..."
  esac
done

echo -e "\n **--Thank you for using the script--**"