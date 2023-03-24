#!/bin/bash
        # Install docker
        apt-get update
        apt-get install -y apt-transport-https ca-certificates curl software-properties-common
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
        add-apt-repository \
            "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
            $(lsb_release -cs) \
            stable"
        apt-get update
        apt-get install -y docker-ce
        sudo usermod -aG docker $USER
        newgrp docker

        # apt-get install -y awscli
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        sudo apt install unzip
        sudo unzip awscliv2.zip
        sudo ./aws/install
        #sudo usermod -aG docker $USER
        #sudo usermod -aG docker jenkins
        #sudo usermod -aG docker aws
        newgrp docker
        echo "install kubectl"
        curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.24.10/2023-01-30/bin/linux/amd64/kubectl
        chmod +x ./kubectl
        mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
        echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc
        kubectl version --short --client
        EOF