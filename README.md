# Automating Infrastructure Deployment and CI/CD with DevOps 🚀

## Introduction
 This project aims to automate the deployment of infrastructure and enable continuous integration and continuous deployment (CI/CD) for a web application. The infrastructure is deployed using Terraform, which sets up an EC2 instance, Elastic Container Registry (ECR), and Elastic Kubernetes Service (EKS). Ansible is then used to install necessary tools such as Jenkins, Docker, Kubectl, and AWS-cli on the EC2 instance.

<br>

## Infrastructure setup
 With the infrastructure set up, a Jenkins pipeline is created to detect changes in the code on GitHub. Whenever a change is detected, a Docker image is built and pushed to ECR. The pipeline then deploys the pods and deployments using the newly pushed image on the ECR, ensuring that the latest code changes are always available on the webserver backed by MySQL. This process enables quick and efficient deployment of updates to the web application, while minimizing human error and downtime.

## Features
[x] T1
[x] T2
<br><br>

## Prerequisites (Tools)
- Terraform [Click here to install](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- Ansible [Click here to install](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)


## Preparation

- Clone Repo.
- Create folder called "**creds**"
  - Create file called "**ansible-keypair.pem**"
    - run `chmod 600 ansible-keypair.pem`
    - file content structure should be:
      ```
      -----BEGIN RSA PRIVATE KEY-----
      <PASTE_PEM_KEY_HERE>
      -----END RSA PRIVATE KEY-----
      ```
  - Create file called "**aws_creds**"
    - file content Structure should be:
      ```json 
      {
      "AWS_ACCESS_KEY_ID" : "<YOUR_AWS_ID>",
      "AWS_SECRET_ACCESS_KEY" : "<YOUR_AWS_KEY>"
      }
      ```

## Deployment
1. navigate to terraform directory and run `terrafrom apply`. Once completed successfully, proceed to step 2.
2. Navigate to Ansible directory and run  `ansible-playbook main.ansible`.yaml
    -  NOTE: Ansible will use the configured host name which were added to hosts file [/etc/hosts].
    - hostname used in this repo for the EC2 instance is `aws.metallized.project`.


## Accessing Deployments

### Access to EC2:
To access EC2 instance via ssh you can run `ssh -i /creds/ansible-keypair.pem aws.metallized.project`.
### Access to Jenkins UI
To access jenkins UI you can use the IP of the EC2, you can get the ip using 3 differernt methods:
  - run `grep aws.metalllized.project /etc/hosts`
  - run from within the `terraform` directory `terraform output public_ip`
  - or run `nslookup aws.metallized.project localhost`
