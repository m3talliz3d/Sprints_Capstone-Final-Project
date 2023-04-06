#!/bin/bash

#Set ENV_VAR to the project directory
export CAPSTONE_PROJECT="$(cd .. && export TEST=$PWD && echo $TEST)"
CONFIG_FILE="$HOME/.ssh/config"

if [[ -s "$CONFIG_FILE" ]]; then # If config File is empty
  # Create an include entry in ~/.ssh/config
  # and Skip if already available
  if grep -qE "Include|creds" $CONFIG_FILE; then
    echo "Entry already available in config file"
  else
  sed -i "1s|^|Include $CAPSTONE_PROJECT/creds/config \n |" $CONFIG_FILE
  fi
else
echo "Include $CAPSTONE_PROJECT/creds/config" > $CONFIG_FILE # overwrite the file directly
fi