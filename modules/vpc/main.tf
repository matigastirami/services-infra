resource "aws_vpc" "services_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = var.tags
}

resource "aws_subnet" "private_subnet" {
  count = length(var.private_subnets_az)
  cidr_block = "10.0.${count.index}.0/24"
  vpc_id = aws_vpc.services_vpc.id
  availability_zone = var.private_subnets_az[count.index]
  tags = var.tags
}

resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnets_az)
  cidr_block = "10.0.${count.index + 2}.0/24"
  vpc_id = aws_vpc.services_vpc.id
  availability_zone = var.public_subnets_az[count.index]
  tags = var.tags
}