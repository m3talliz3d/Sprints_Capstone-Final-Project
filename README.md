# Automating Infrastructure Deployment and CI/CD with DevOps 🚀

## Table of content
[Introduction](#Introduction)

## Introduction
 This project aims to automate the deployment of infrastructure and enable continuous integration and continuous deployment (CI/CD) for a web application. The infrastructure is deployed using Terraform, which sets up an EC2 instance, Elastic Container Registry (ECR), and Elastic Kubernetes Service (EKS). Ansible is then used to install necessary tools such as Jenkins, Docker, Kubectl, and AWS-cli on the EC2 instance.

![image](sprints_capstone_mod.png)
<br>

## Infrastructure setup
 With the infrastructure set up, a Jenkins pipeline is created to detect changes in the code on GitHub. Whenever a change is detected, a Docker image is built and pushed to ECR. The pipeline then deploys the pods and deployments using the newly pushed image on the ECR, ensuring that the latest code changes are always available on the webserver backed by MySQL. This process enables quick and efficient deployment of updates to the web application, while minimizing human error and downtime.

## Perks
**Scripts:**
- :zap: Script: Create a "case" script to provide multiple options to deployment.
  - :white_check_mark: option 1: Prepare Credential folder.
  - :white_check_mark: Option 2: Run Terrafrom > Run Ansible.
  - :white_check_mark: Option 3: Run Terraform.
  - :white_check_mark: Option 4: Run Asible.
  - :white_check_mark: Option 5: Detroy Terraform.
  - :white_check_mark: Option 6: Cleanup creds & revert ssh_config changes.
- :x: Script: Create "creds" directory and include the required credentials.
- :white_check_mark: Script: append "<project_directory>/creds/config" in ~/.ssh/config file.
- :white_check_mark: Script: Remove added line only to "~/.ssh/config" file as a cleanup process.
<br>

**Terraform:**
- :white_check_mark: Terraform: Add IP & FQDN to hosts file on EC2 creation.
- :white_check_mark: Terraform: Remove IP & FQDN to hosts file on EC2 Destroy.
- :white_check_mark: Terrafrom: Output PEM file key to `creds/ansible-keypair.pem`
<br>

**Jenkins:**
- :x: Jenkins: Script to help Dev Change Github token.
- :x: Jenkins: Script to help Dev change AWS_SECRET_ACCESS_KEY.
- :x: Jenkins: Script to help Dev change AWS_SECRET_ACCESS_ID.

**Security:**
- :x: Checksum: Add md5 Checksum for scripts to verify scripts integrity since you already provide sensitive credentials.
<br><br>

## Prerequisites (Tools)
- Terraform [Click here to install](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- Ansible [Click here to install](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)


## Preparation

- ### Clone Repo.
- ~~Create folder called "**creds**"~~
  - ~~Create file called "**ansible-keypair.pem**"~~
    - ~~run `chmod 600 ansible-keypair.pem`~~
    - file content structure should be:
      ```
      -----BEGIN RSA PRIVATE KEY-----
      <PASTE_PEM_KEY_HERE>
      -----END RSA PRIVATE KEY-----
      ```
      **The above is no longer required since script was updated in the [Perks Section](#Perks) section to be done automatically.**
      
      <br>
  - Create file called "**aws_creds**"
    - file content Structure should be:
      ```json 
      {
      "AWS_ACCESS_KEY_ID" : "<YOUR_AWS_ID>",
      "AWS_SECRET_ACCESS_KEY" : "<YOUR_AWS_KEY>"
      }
      ```
- ### On Terraform destroy you will have issue with deleteing VPC and it will fail, workaround:
  - login to AWS console and navigate to EC2
    - Go to loadbalancer and delete ELB.
    - Then navigate to Network Interfaces and delete any created.
  - Navigate to VPC:
    - go to "Your VPC" and delete the created VPC.
    - Run the script again and choose option "5".

## Deployment
1. navigate to terraform directory and run `terrafrom apply`. Once completed successfully, proceed to step 2.
2. Navigate to Ansible directory and run  `ansible-playbook main.ansible`.yaml
    -  NOTE: Ansible will use the configured host name which were added to hosts file [/etc/hosts].
    - hostname used in this repo for the EC2 instance is `aws.metallized.project`.


## Accessing Deployments

### ~~Access to EC2~~
~~To access EC2 instance via ssh you can run `ssh -i /creds/ansible-keypair.pem aws.metallized.project`.~~
Has been implemented in [Perks Section](#Perks) and now you just need to use `ssh aws.metallized.project` only since ssh_config file include the full path for the PEM file
### Access to Jenkins UI
To access jenkins UI you can use the IP of the EC2, you can get the ip using 3 differernt methods:
  - run `grep aws.metalllized.project /etc/hosts`
  - run from within the `terraform` directory `terraform output public_ip`
  - or run `nslookup aws.metallized.project localhost`


## Known Issues
- ### ssh to `aws.metallized.project` show error
  ```bash
  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  @    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
  Someone could be eavesdropping on you right now (man-in-the-middle attack)!
  .
  .
  .
  Add correct host key in /home/$USER/.ssh/known_hosts to get rid of this message.
  Offending ECDSA key in /home/&USER/.ssh/known_hosts:2
  ECDSA host key for aws.metallized.project has changed and you have requested strict checking.
  Host key verification failed.
  ```
  - #### Solution
    - type `ssh-keygen -R aws.metallized.project` in the terminal and it will remove the old fingerprint


## Issues & Contributions
So far I am not familiar with maintaining issues on the project, yet it is still work in progress and trying to make sure that most issues is resolved, I will keep updating the [Issues Section](#Known-Issues).

Yet, I would love to hear feedback if you had any issues running the project.