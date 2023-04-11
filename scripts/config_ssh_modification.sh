#!/bin/bash

hello_world(){
  echo "Hello World!!"
}

create_include_config_ssh(){
  #Set ENV_VAR to the project directory
#  CAPSTONE_PROJECT=$(dirname $(find $HOME -type f -name "test.sh"  2> /dev/null | grep -w scripts))
  CONFIG_FILE="$HOME/.ssh/config"
  echo $CAPSTONE_PROJECT

  if [[ -s "$CONFIG_FILE" ]]; then # If config File is empty
    # Create an include entry in ~/.ssh/config
    # and Skip if already available
    if grep -qE "Include|creds" $CONFIG_FILE; then
      echo "Entry already available in config file"
    else
    sed -i "1s|^|Include $CAPSTONE_PROJECT/creds/config \n |" $CONFIG_FILE
    fi
  else
  # overwrite the file directly
  echo "Include $CAPSTONE_PROJECT/creds/config" > $CONFIG_FILE 
  fi
}


remove_include_config_ssh(){
  sed -i "/creds/d" ~/.ssh/config
}

create_config_file(){
  `cat << EOT > creds/config
  Host aws.metallized.project
    HostName aws.metallized.project
    User ubuntu
    IdentityFile $CAPSTONE_PROJECT/creds/ansible-keypair.pem
    StrictHostKeyChecking no`
}

create_pem_file(){
  terraform -chdir=terraform output private_key_pem | grep -v EOT > creds/ansible-keypair.pem
}