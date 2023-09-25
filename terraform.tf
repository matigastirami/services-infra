terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.49.0"
    }
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "1.11.1"
    }
  }

  required_version = ">= 1.5.0"
}