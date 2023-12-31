variable "env" {
  description = "Environment name"
  type = string
}

variable "vpc_cidr_block" {
  description = "CIRD (Classless Inter-Domain Routing)"
  type = string
  default = "10.0.0.0/16"
}

variable "azs" {
  description = "Availability zones for subnets"
  type = list(string)
}

variable "private_subnets" {
  description = "CIDR ranges for private subnets"
  type = list(string)
}

variable "public_subnets" {
  description = "CIDR ranges for public subnets"
  type = list(string)
}

variable "private_subnet_tags" {
  description = "Tags for the private subnets"
  type = map(any)
}

variable "public_subnet_tags" {
  description = "Tags for the public subnets"
  type = map(any)
}