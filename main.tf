terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.12.0"
    }
  }
  required_version = ">= 1.5.5"
}

provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "services_vpc" {

}

resource "aws_security_group" "services_sec_group" {
  name = "services_sec_group"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app_server" {
  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type
  tags = {
    name = var.instance_name
  }
  security_groups = [aws_security_group.services_sec_group.id]
}

#resource "aws_iam_role" "eks_cluster_role" {
#  assume_role_policy = ""
#
#}
#
#resource "aws_eks_cluster" "services_cluster" {
#  name     = var.eks_cluster_name
#  role_arn = aws_iam_role.eks_cluster_role.arn
#  version  = var.eks_kubernetes_version
#  kubernetes_network_config {
#    ip_family         = "0.0.0.0/0"
#    service_ipv4_cidr = "WTF_IS_THIS"
#  }
#  vpc_config = {
#    subnet_ids = {}
#    security_group_ids = {}
#  }
#  enabled_cluster_log_types {}
#}