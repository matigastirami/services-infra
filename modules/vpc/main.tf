resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "private_subnet" {
  count = 2
  cidr_block = "10.0.${count.index}.0/24"
  vpc_id = aws_vpc.my_vpc.id
  availability_zone = "us-east-1a" # Replace with your desired AZ
}

resource "aws_subnet" "public_subnet" {
  count = 2
  cidr_block = "10.0.${count.index + 2}.0/24"
  vpc_id = aws_vpc.my_vpc.id
  availability_zone = "us-east-1a" # Replace with your desired AZ
}