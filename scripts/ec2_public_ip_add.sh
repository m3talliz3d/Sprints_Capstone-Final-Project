#!/bin/bash

# Copy public IP output to PUBLIC_IP variable
sleep 5
PUBLIC_IP=$(terraform -chdir=../terraform output public_ip | cut -d'"' -f2) 

# Add public IP to hosts file
sleep 5
echo "${PUBLIC_IP}   aws.metallized.project" | sudo tee -a /etc/hosts > /dev/null