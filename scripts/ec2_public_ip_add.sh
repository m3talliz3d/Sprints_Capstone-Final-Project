#!/bin/bash

# Copy public IP output to PUBLIC_IP variable
sleep 5
#export PUBLIC_IP=$(terraform -chdir=../terraform output public_ip | cut -d'"' -f2) 
export PUBLIC_IP=$(cat ../terraform/terraform.tfstate| grep -w public_ip | cut -d '"' -f4 | grep -v '^\d*$')
# Add public IP to hosts file
sleep 5
echo "${PUBLIC_IP}   aws.metallized.project" | sudo tee -a /etc/hosts > /dev/null