#!/bin/bash

jenkins_password(){
  read -p "Type Github Token: " GITHUB
  AWS_ID=`cat creds/aws_creds | grep ID | cut -d '"' -f4`
  AWS_KEY=`cat creds/aws_creds | grep SECRET_ACC | cut -d '"' -f4`
  ssh -qt aws.metallized.project 'bash -s' < scripts/jenkins_p2_PassGen.sh $GITHUB $AWS_KEY $AWS_ID
}