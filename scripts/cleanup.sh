#!/bin/bash

remove_include_config_ssh(){
  sed -i "/creds/d" ~/.ssh/config
}