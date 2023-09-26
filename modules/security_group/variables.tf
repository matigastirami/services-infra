variable "tags" {
  description = "Default tags for resources"
  type = object({
    environment = string,
    terraform = optional(bool, "true")
  })
}

variable "vpc_id" {
  description = "The ID of the VPC this sec group will be available for"
  type = string
}

variable "eks_cluster_cidr_block" {
  default = "CIDR block of the EKS cluster"
  type = string
}