variable "tags" {
  description = "default tags for resources"
  type = object({
    environment = string,
    terraform   = optional(bool, "true")
  })
}

variable "private_subnets_az" {
  description = "Availability zones for the private subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
  validation {
    condition     = length(var.private_subnets_az) >= 2
    error_message = "You must provide at least 2 availability zones for your private subnets"
  }
}

variable "public_subnets_az" {
  description = "Availability zones for the public subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
  validation {
    condition     = length(var.public_subnets_az) >= 2
    error_message = "You must provide at least 2 availability zones for your public subnets"
  }
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "cluster_name" {
  description = "Name for the EKS cluster under this VPC"
  type = string
  default = "services-cluster"
}