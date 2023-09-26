output "vpc_id" {
  value = aws_vpc.services_vpc.id
}

output "private_subnets_ids" {
  value = aws_subnet.private_subnet[*].id
}

output "vpc_cidr_block" {
  value = aws_vpc.services_vpc.cidr_block
}