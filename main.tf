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

resource "aws_ecr_repository" "users-service" {
  name = "users-service"
  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_subnet" "subnet" {
  vpc_id = aws_vpc.services_vpc.id
}

// This data source makes the configuration deployable to any aws region
// it can be referenced as `data.aws_availability_zones.available.names`
// it's specially useful when sharing configurations between terraform workspaces
data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name = "zone-type"
    values = ["availability-zone"]
  }
}

// This makes available the current region
data "aws_region" "current" { }

// This data block helps sharing data between workspaces/repositories
data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "path/to/tfstate/file/in/another/repo"
  }
}

# TODO: check how to provide atlas instance
provider "mongodbatlas" {
  region = var.aws_region
}

locals {
  name_suffix = "${var.resource_tags["project"]}-${var.resource_tags["environment"]}"
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "services_vpc" {

}

resource "aws_security_group" "services_sec_group" {
  name = "services_sec_group-${local.name_suffix}"
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

resource "mongodbatlas_database_user" "db_user" {
  project_id = ""
  username   = ""
}

resource "mongodbatlas_cluster" "mongodb_cluster" {
  name                        = "db-cluster-${local.name_suffix}"
  project_id                  = ""
  provider_instance_size_name = ""
  provider_name               = ""
}

resource "aws_instance" "app_server" {
  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type
  tags = {
    name = "${var.instance_name}-${local.name_suffix}"
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