output "vpc_id" {
  value = aws_vpc.services_vpc.id
}

output "private_subnets_ids" {
  value = var.private_subnets_count > 1 ? aws_subnet.private_subnet[*].id : aws_subnet.private_subnet.id
}