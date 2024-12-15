#!/bin/bash
yum update -y
yum install docker -y
service docker start
usermod -a -G docker ec2-user
dnf install amazon-ecr-credential-helper -y
aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin 642069671695.dkr.ecr.${REGION}.amazonaws.com
docker pull 642069671695.dkr.ecr.${REGION}.amazonaws.com/${ECR_REPOSITORY}:${IMG_TAG}
docker run -p 80:3000 642069671695.dkr.ecr.${REGION}.amazonaws.com/${ECR_REPOSITORY}:${IMG_TAG}

# Install mysql
dnf install mariadb105
# mysql -h terraform-rds.c1q6wy8eqd8z.us-east-1.rds.amazonaws.com -u admin -p