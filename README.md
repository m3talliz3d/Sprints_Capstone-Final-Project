# Automating Infrastructure Deployment and CI/CD with DevOps 🚀

## Introduction
#### This project aims to automate the deployment of infrastructure and enable continuous integration and continuous deployment (CI/CD) for a web application. The infrastructure is deployed using Terraform, which sets up an EC2 instance, Elastic Container Registry (ECR), and Elastic Kubernetes Service (EKS). Ansible is then used to install necessary tools such as Jenkins, Docker, Kubectl, and AWS-cli on the EC2 instance.
<br />

## Infrastructure setup
#### With the infrastructure set up, a Jenkins pipeline is created to detect changes in the code on GitHub. Whenever a change is detected, a Docker image is built and pushed to ECR. The pipeline then deploys the pods and deployments using the newly pushed image on the ECR, ensuring that the latest code changes are always available on the webserver backed by MySQL. This process enables quick and efficient deployment of updates to the web application, while minimizing human error and downtime.