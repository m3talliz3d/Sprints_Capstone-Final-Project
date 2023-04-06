#!/bin/bash

#Set ENV_VAR to the project directory
export CAPSTONE_PROJECT="$(cd .. && export TEST=$PWD && echo $TEST)"

# Create an include entry in ~/.ssh/config
# and Skip if already available 
if grep -qE "Include|creds" ~/.ssh/config; then
  echo "Entry already available in config file"
else
sed -i "1s|^|Include $CAPSTONE_PROJECT/creds/config \n |" ~/.ssh/config
fi