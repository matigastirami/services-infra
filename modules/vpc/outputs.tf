output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets_ids" {
  value = module.vpc.private_subnets
}

#output "public_subnets_ids" {
#  value = aws_subnet.public_subnet[*].id
#}

output "vpc_sec_group_id" {
  value = module.vpc.default_security_group_id
}

output "vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}