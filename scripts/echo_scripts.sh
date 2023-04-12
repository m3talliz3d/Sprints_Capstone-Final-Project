#!/bin/bash

echo_terraform_deploy(){
  echo "##################################"
  echo "Terrafrom Deployment is successful"
  echo "Created creds/ansible-keypair.pem "
  echo "##################################"
}

echo_terraform_destroy(){
  echo "##################################"
  echo "Terrafrom Deployment is Destroyed"
  echo "##################################"
}

echo_ansible_ansible(){
  echo "##################################"
  echo "Ansible Playbook is successful"
  echo "##################################"
}