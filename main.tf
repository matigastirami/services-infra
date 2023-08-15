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
