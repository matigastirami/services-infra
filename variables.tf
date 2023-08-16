variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_name" {
  description = "Tag name for the EC2 instance"
  type        = string
  default     = "services_ec2_instance"
}

variable "ec2_instance_type" {
  description = "Type of instance"
  type        = string
  default     = "t2.micro"
}

variable "ec2_ami" {
  description = "AMI for aws ec2 instance"
  type        = string
  default     = "ami-053b0d53c279acc90" # Ubuntu Server 22.04 LTS Free tier eligible
}

variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "instance_count" {
  description = "Number of instances to provision."
  type        = number
  default     = 1

  validation {
    condition = var.instance_count <= 2
    error_message = "Can't provide more than 2 EC2 instances"
  }
}

variable "eks_cluster_name" {
  description = "Name for the EKS cluster running the services"
  type = string
  default = "services_cluster_development"
}

variable "eks_kubernetes_version" {
  description = "What K8s version should the cluster use"
  type = string
  default = "1.27"
}