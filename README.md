# Automating Infrastructure Deployment and CI/CD with DevOps 🚀

## Introduction
 This project aims to automate the deployment of infrastructure and enable continuous integration and continuous deployment (CI/CD) for a web application. The infrastructure is deployed using Terraform, which sets up an EC2 instance, Elastic Container Registry (ECR), and Elastic Kubernetes Service (EKS). Ansible is then used to install necessary tools such as Jenkins, Docker, Kubectl, and AWS-cli on the EC2 instance.

<br>

## Infrastructure setup
 With the infrastructure set up, a Jenkins pipeline is created to detect changes in the code on GitHub. Whenever a change is detected, a Docker image is built and pushed to ECR. The pipeline then deploys the pods and deployments using the newly pushed image on the ECR, ensuring that the latest code changes are always available on the webserver backed by MySQL. This process enables quick and efficient deployment of updates to the web application, while minimizing human error and downtime.

## Features
<br><br>

## Prerequisites
- Terraform [Click here to install](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- Ansible [Click here to install](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)


## Installation

- Clone Repo.
- Create folder called "**creds**"
  - Create file called "**ansible-keypair.pem**"
    - run `chmod 600 ansible-keypair.pem`
    - structure should be
      ```
      -----BEGIN RSA PRIVATE KEY-----
      <PASTE_PEM_KEY_HERE>
      -----END RSA PRIVATE KEY-----
      ```
  - Create file called "**aws_creds**"
    - Structure should be 
      ```json 
      {
      "AWS_ACCESS_KEY_ID" : "<YOUR_AWS_ID>",
      "AWS_SECRET_ACCESS_KEY" : "<YOUR_AWS_KEY>"
      }
      ```

