#variable "aws_region" {
#  description = "AWS region"
#  type        = string
#  default     = "us-east-1"
#}

variable "project_name" {
  description = "A project name to be used in resources"
  type        = string
  default     = "atlas-eks"
}

variable "component" {
  description = "A team using this project (backend, web, ios, data, devops)"
  type = string
}

variable "environment" {
  description = "Dev/Prod, will be used in AWS resources Name tag, and resources names"
  type        = string
}

variable "eks_version" {
  description = "Kubernetes version, will be used in AWS resources names and to specify which EKS version to create/update"
  type        = string
}

# TODO: move to a safe place as setting for example: MONGODB_ATLAS_PUBLIC_KEY and MONGODB_ATLAS_PRIVATE_KEY or using aws secrets manager
variable "mongodb_atlas_keys" {
  type = map(string)
  default = {
    public_key : "rabmlvaw",
    private_key : "c2c3579d-40bb-4da2-bae9-b468a4b907a6"
  }
  description = "Name of the project in mongodb atlas"
}