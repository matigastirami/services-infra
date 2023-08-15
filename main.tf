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
  region = "us-east-1"

}

resource "aws_instance" "app_server" {
  ami           = "ami-053b0d53c279acc90" # Ubuntu Server 22.04 LTS Free tier elegible
  instance_type = "t2.micro"
  tags = {
    name = var.instance_name
  }
}

#resource "aws_iam_role" "eks_cluster_role" {
#  assume_role_policy = ""
#
#}
#
#resource "aws_eks_cluster" "services_cluster" {
#  name     = "services_cluster"
#  role_arn = aws_iam_role.eks_cluster_role.arn
#  version  = "1.27"
#  kubernetes_network_config {
#    ip_family         = "0.0.0.0/0"
#    service_ipv4_cidr = "WTF_IS_THIS"
#  }
#  vpc_config {
#    subnet_ids {}
#  }
#}