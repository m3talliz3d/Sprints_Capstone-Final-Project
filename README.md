# Automating Infrastructure Deployment and CI/CD with DevOps 🚀


<details>
  <summary> Table of Contents </summary>

- [Automating Infrastructure Deployment and CI/CD with DevOps 🚀](#automating-infrastructure-deployment-and-cicd-with-devops-)
  - [Introduction](#introduction)
  - [Infrastructure setup overview](#infrastructure-setup-overview)
  - [Prerequisites (Tools)](#prerequisites-tools)
  - [Perks](#perks)
      - [**Scripts:**](#scripts)
      - [**Terraform:**](#terraform)
      - [**Jenkins:**](#jenkins)
      - [**Security:**](#security)
  - [Preparation](#preparation)
  - [Deployment](#deployment)
      - [Deploy Project:](#deploy-project)
      - [Push credentials to Jenkins (Encoded):](#push-credentials-to-jenkins-encoded)
      - [Destroy Deployment:](#destroy-deployment)
      - [Cleanup:](#cleanup)
  - [Tips](#tips)
    - [SSH to EC2 instace:](#ssh-to-ec2-instace)
    - [Filter git commits by tool:](#filter-git-commits-by-tool)
  - [Scripts Breakdown](#scripts-breakdown)
  - [Known Issues](#known-issues)
  - [Planned Changes](#planned-changes)
  - [Issues \& Contributions](#issues--contributions)
</details>

## Introduction
 This project aims to automate the deployment of infrastructure and enable continuous integration and continuous deployment (CI/CD) for a web application. The infrastructure is deployed using Terraform, which sets up an EC2 instance, Elastic Container Registry (ECR), and Elastic Kubernetes Service (EKS). Ansible is then used to install necessary tools such as Jenkins, Docker, Kubectl, and AWS-cli on the EC2 instance.

![image](sprints_capstone_mod.png)
<br>

## Infrastructure setup overview
 With the infrastructure set up, a **Jenkins** pipeline is created to detect changes in the code on **GitHub**. Whenever a change is detected, a **Docker image** is built and pushed to **ECR**. 
 <br>

 The pipeline then deploys the pods and deployments using the newly pushed image on the ECR, ensuring that the latest code changes are always available on the webserver backed by MySQL. 
 <br>

 This process enables quick and efficient deployment of updates to the web application, while minimizing human error and downtime.

## Prerequisites (Tools)
- Terraform [Click here to install](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- Ansible [Click here to install](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

## Perks
#### **Scripts:**
- :zap: Script: Create a "case" script to provide multiple options to deployment.
  - :white_check_mark: option 1: Prepare Credential folder.
  - :white_check_mark: Option 2: Run Terrafrom > Run Ansible.
  - :white_check_mark: Option 3: Run Terraform.
  - :white_check_mark: Option 4: Run Asible.
  - :x: Option 5: SSH to EC2. (coming soon...)
  - :white_check_mark: Option 6: Push credentials to Jenkins.
  - :white_check_mark: Option 7: Detroy Terraform.
  - :white_check_mark: Option 8: Cleanup creds & revert ssh_config changes.
- :white_check_mark: Script: Create "creds" directory and include the required credentials.
- :white_check_mark: Script: append "<project_directory>/creds/config" in ~/.ssh/config file.
- :white_check_mark: Script: Remove added line only to "~/.ssh/config" file as a cleanup process.
<br>

#### **Terraform:**
- :white_check_mark: Terraform: Add IP & FQDN to hosts file on EC2 creation.
- :white_check_mark: Terraform: Remove IP & FQDN to hosts file on EC2 Destroy.
- :white_check_mark: Terrafrom: Output PEM file key to `creds/ansible-keypair.pem`
<br>

#### **Jenkins:**
- :white_check_mark: Jenkins: Script to help Dev Change Github token.
- :white_check_mark: Jenkins: Script to help Dev change AWS_SECRET_ACCESS_KEY.
- :white_check_mark: Jenkins: Script to help Dev change AWS_SECRET_ACCESS_ID.

#### **Security:**
- :white_check_mark: Checksum: Scripts - Add md5 Checksum for scripts to verify scripts integrity since you already provide sensitive credentials.
- :white_check_mark: Checksum: Ansible Playbook - sh256 check on jenkins backup restoration
<br><br>


## Preparation
<text style="color:darkred">*Note: This step is crucial for the infrastructer to get deployed.*</text>
<br>

**Attention:** *Script will perform checksum verification on all the scripts in `creds` directory, in case any change occured in the scripts you will be aware. [Checksum perk](#security) has been included in the script make sure that your credentials are used safely and no modification has been performed.*

- Clone Repo.
- Prepare credentials:
  - Github token
  - AWS ID
  - AWS KEY
- Run `RunMe.sh` script:
  - Choose **option "1"** to prepare the credentials directory.
  - Paste AWS KEY & AWS ID as requested. 

## Deployment
#### Deploy Project:
- Run `RunMe.sh` script:
  - Choose **option "2"** to deploy Infrastructure
    - In case issue occuured during **option "2"** you can use **option "3"** and/or **option "4"**.

#### Push credentials to Jenkins (Encoded):
*<text style="color:darkred">Note: Jenkins service will get restarted at the end of this process.*</text>
<br>
*Note: all encoding is done on the remote server*
- Run `RunMe.sh` script:
  - Choose **option "5"** (prepare Github Token) and paste the Github token when requested.
  - option "5" will automatically use AWS credentials in creds directory.
  - give it some time to reflect

#### Destroy Deployment:
*<text style="color:darkred">Note: Please refer to [known issues](#known-issues) section as there is ongoing issue with fully destroying infrastruture*</text>. Fix still in progress.
- Run `RunMe.sh` script:
  - Choose **option "6"** to destroy the infrastructure.

#### Cleanup:
- Run `RunMe.sh` script:
  - **option "7"** will perform:
    - Deletion of "creds" directory.
    - Revert back change to `~/.ssh/config`



## Tips
### SSH to EC2 instace:
To access jenkins UI you can use the IP of the EC2, you can get the ip using 3 differernt methods:
  - run `grep aws.metalllized.project /etc/hosts`
  - run from within the `terraform` directory `terraform output public_ip`
  - or run `nslookup aws.metallized.project localhost`

### Filter git commits by tool:
To filter commits by `terrafrom` or `jenkins` or `script` type this command 
`git log --decorate=short --all | grep -i <tool_name>` in the terminal

## Scripts Breakdown


## Known Issues
1. #### ssh to `aws.metallized.project` show error
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
  - ##### Solution
    - type `ssh-keygen -R aws.metallized.project` in the terminal and it will remove the old fingerprint
    - Will be solved with **option "5"** in the [Perks section](#perks)


2. #### On Terraform destroy you will have issue with deleteing VPC and it will fail, workaround:
  - login to AWS console and navigate to EC2
    - Go to loadbalancer and delete ELB.
    - Then navigate to Network Interfaces and delete any created.
  - Navigate to VPC:
    - go to "Your VPC" and delete the created VPC.
    - Run the script again and choose option "5".

## Planned Changes
- [ ] Ansible: Change Ansible directory to Galaxy.
- [ ] Terrafrom: Change Teraaform directory to  Modules.
- [ ] Terraform: Import Network interfaces & ELB to Terraform to fix issue in the [known issues section](#on-terraform-destroy-you-will-have-issue-with-deleteing-vpc-and-it-will-fail-workaround)

## Issues & Contributions
So far I am not familiar with maintaining issues on the project, yet it is still work in progress and trying to make sure that most issues is resolved, I will keep updating the [Issues Section](#Known-Issues).

Yet, I would love to hear feedback if you had any issues running the project.