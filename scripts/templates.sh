#!/bin/bash

create_config_file(){
  `cat << EOT > creds/config
  Host aws.metallized.project
    HostName aws.metallized.project
    User ubuntu
    IdentityFile $CAPSTONE_PROJECT/creds/ansible-keypair.pem
    StrictHostKeyChecking no`
}

create_aws_creds(){
  echo "Type your AWS_ID:"
  read AWS_ID
  echo "Type your AWS_ID:"
  read AWS_KEY
  `cat << EOT > creds/aws_creds
{
  "AWS_ACCESS_KEY_ID" : "$AWS_ID",
  "AWS_SECRET_ACCESS_KEY" : "$AWS_KEY"
}`
}