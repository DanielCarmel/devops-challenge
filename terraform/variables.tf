variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "instance_name" {
  description = "Name for the EC2 instance"
  type        = string
  default     = "ExampleAppServerInstance"
}

variable "instance_ami" {
  description = "Ami for the EC2 instance"
  type        = string
  default     = "ami-0453ec754f44f9a4a"
}

variable "instance_type" {
  description = "Type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Value of the key pair to attach"
  type        = string
  default     = "daniel-laptop"
}

variable "AWS_ACCESS_KEY_ID" {
  description = "AWS Access Key ID"
  type        = string
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS Secret Access Key ID"
  type        = string
}

variable "image_tag" {
  description = "Docker image tag"
  type        = string
}

variable "ecr_repository" {
  description = "ECR repo name"
  type        = string
}

# These are things we'll use in various places
locals {
  tags = {
    Terraform     = "true"
    Region        = var.region
  }
}