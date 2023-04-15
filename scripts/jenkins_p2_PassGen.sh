#!/bin/bash

# Environment variable
JEN_HOME="/var/lib/jenkins"
TEMP=$(mktemp)

GITHUB="$1"
AWS_KEY="$2"
AWS_ID="$3"

## Functions ##
pass_gen(){
  sed "s|changeme|$PASSW|" $JEN_HOME/encode_password.groovy > $TEMP
  PASSW=`java -jar $JEN_HOME/jenkins-cli.jar -s http://localhost:8080 -auth admin:ChangePassword groovy = < $TEMP`
}

id_github(){
  sudo sed -i "14s|{.*}|$PASSW|" $JEN_HOME/credentials.xml
}

id_aws_key(){
  sudo sed -i "21s|{.*}|$PASSW|" $JEN_HOME/credentials.xml
}

id_aws_id(){
  sudo sed -i "27s|{.*}|$PASSW|" $JEN_HOME/credentials.xml
}


# Main Script
sed "s|changeme|$GITHUB|" $JEN_HOME/encode_password.groovy > $TEMP
#PASSW=$GITHUB
PASSW=`java -jar $JEN_HOME/jenkins-cli.jar -s http://localhost:8080 -auth admin:ChangePassword groovy = < $TEMP`
id_github

sed "s|changeme|$AWS_KEY|" $JEN_HOME/encode_password.groovy > $TEMP
#PASSW=$AWS_KEY
PASSW=`java -jar $JEN_HOME/jenkins-cli.jar -s http://localhost:8080 -auth admin:ChangePassword groovy = < $TEMP`
id_aws_key

sed "s|changeme|$AWS_ID|" $JEN_HOME/encode_password.groovy > $TEMP
#PASSW=$AWS_ID
PASSW=`java -jar $JEN_HOME/jenkins-cli.jar -s http://localhost:8080 -auth admin:ChangePassword groovy = < $TEMP`
id_aws_id

rm $TEMP