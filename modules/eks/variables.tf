variable "private_subnet_ids" {
  description = "IDs of the private subnets this EKS cluster belongs to"
  type        = list(string)
}

variable "security_group_id" {
  description = "ID of the security group"
  type        = string
}