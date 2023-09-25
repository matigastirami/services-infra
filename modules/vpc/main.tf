resource "aws_vpc" "services_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = var.tags
}

resource "aws_subnet" "private_subnet" {
  count = var.private_subnets_count > 0 ? var.private_subnets_count : 1
  cidr_block = "10.0.${count.index}.0/24"
  vpc_id = aws_vpc.services_vpc.id
  availability_zone = "us-east-1a"
  tags = var.tags
}

resource "aws_subnet" "public_subnet" {
  count = var.private_subnets_count > 0 ? var.private_subnets_count : 1
  cidr_block = "10.0.${count.index + 2}.0/24"
  vpc_id = aws_vpc.services_vpc.id
  availability_zone = "us-east-1a"
  tags = var.tags
}