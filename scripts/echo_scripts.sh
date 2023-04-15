#!/bin/bash

echo_terraform_deploy(){
  echo -e "\n##################################"
  echo "Terrafrom Deployment is successful"
  echo "Created creds/ansible-keypair.pem "
  echo "##################################"
}

echo_terraform_destroy(){
  echo -e "\n##################################"
  echo "Terrafrom Deployment is Destroyed"
  echo "##################################"
}

echo_ansible_ansible(){
  echo -e "\n##################################"
  echo "Ansible Playbook is successful"
  echo "##################################"
}

echo_remove_include_config_ssh(){
  echo -e "\n###################################"
  echo "Removed custom line on /.ssh/config"
  echo "###################################"
}

echo_delete_creds_dir(){
  echo -e "\n##################################"
  echo "    Removed 'creds' Directory     "
  echo "##################################"
}