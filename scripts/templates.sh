#!/bin/bash

create_config_file(){
  `cat << EOT > creds/config
  Host aws.metallized.project
    HostName aws.metallized.project
    User ubuntu
    IdentityFile $CAPSTONE_PROJECT/creds/ansible-keypair.pem
    StrictHostKeyChecking no`
}