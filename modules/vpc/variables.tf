variable "tags" {
  description = "default tags for resources"
  type = object({
    environment = string,
    terraform = optional(bool, "true")
  })
}

variable "private_subnets_count" {
  description = "How much private subnets should this module provide"
  type = number
  default = 1
}

variable "public_subnets_count" {
  description = "How much public subnets should this module provide"
  type = number
  default = 1
}