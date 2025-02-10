# DevOps Challenge

This project demonstrates the build and deployment of a simple application using Terraform, GitHub Actions, and Docker. The workflow involves automating the infrastructure provisioning, building a Docker image, and deploying it to an AWS EC2 instance.

---

## Table of Contents
- [Overview](#overview)
- [Terraform Infrastructure](#terraform-infrastructure)
- [GitHub Actions Workflow](#github-actions-workflow)
- [Docker Integration](#docker-integration)
- [Project Structure](#project-structure)
- [How to Run Locally](#how-to-run-locally)
- [Conclusion](#conclusion)

---

## Overview

The primary goal of this project is to demonstrate a CI/CD pipeline for a Dockerized application. The pipeline includes:

1. **Infrastructure Management**: Provisioning an AWS EC2 instance using Terraform.
2. **Continuous Integration**: Automatically testing and building the Docker image using GitHub Actions.
3. **Deployment**: Deploying the Docker container to the provisioned EC2 instance.
4. **Kubernetes**: Provided deployment files for k8s as well, not implemented since I used minikube to save money
---

## Terraform Infrastructure
### Key Components
1. **Provider Configuration**:
   Terraform is configured to interact with AWS services.
2. **EC2 Instance**:
   A virtual machine is created in AWS to host the application, also provided user-data script that runs docker container and install mysql.
3. **Security Group**:
   A security group is defined to allow traffic on specific ports (e.g., 80 for HTTP and 22 for SSH).

### Usage

1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Plan and apply the configuration:
   ```bash
   terraform plan
   terraform apply -var "image_tag=latest" -var "ecr_repository=danielcarmel/devops-challenge"
   ```

3. Terraform provisions an EC2 instance with the defined configuration and connects it to RDS sql server.

---

## GitHub Actions Workflow

The CI/CD pipeline is defined using GitHub Actions, automating the build, test, and deployment process.

### Workflow Steps

1. **Trigger**:
   The workflow is currently triggered manually because its just as assignment.
2. **Build and Test**:
   The Docker image is built and tested using predefined actions.
3. **Deployment**:
   Trigger `terraform apply` to create/update EC2 infra with deployment script and RDS database.

## Docker Integration
The application is containerized using Docker for consistency and portability.

## Project Structure
```plaintext
.
├── Dockerfile
├── README.md
├── app.py
├── requirements.txt
├── k8s/
│   ├── deployment.yaml
│   └── service.yaml
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
└── .github/
    └── workflows/
        └── ci-cd.yml
```

---

## How to Run Locally

1. Clone the repository:
   ```bash
   git clone https://github.com/DanielCarmel/devops-challenge.git
   cd devops-challenge
   ```

2. Set up Terraform and provision infrastructure.

3. Push code to trigger the GitHub Actions pipeline.

4. Verify the application is running on the EC2 instance.
---

## Conclusion
This project showcases a streamlined CI/CD process integrating Terraform, Docker, and GitHub Actions to deploy a containerized application on AWS. By leveraging infrastructure as code and automated pipelines, deployment is consistent, scalable, and efficient.
