#resource "aws_vpc" "services_vpc" {
#  cidr_block           = var.vpc_cidr_block
#  enable_dns_support   = true
#  enable_dns_hostnames = true
#  tags                 = var.tags
#}
#
#resource "aws_subnet" "private_subnet" {
#  count             = length(var.private_subnets_az)
#  cidr_block        = "10.0.${count.index}.0/24"
#  vpc_id            = aws_vpc.services_vpc.id
#  availability_zone = var.private_subnets_az[count.index]
#  tags              = var.tags
#}
#
#resource "aws_subnet" "public_subnet" {
#  count             = length(var.public_subnets_az)
#  cidr_block        = "10.0.${count.index + 2}.0/24"
#  vpc_id            = aws_vpc.services_vpc.id
#  availability_zone = var.public_subnets_az[count.index]
#  tags              = var.tags
#}

#module "vpc" {
#  source = "terraform-aws-modules/vpc/aws"
#  name = "eks-vpc"
#  cidr = "10.0.0.0/16"
#  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
#  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
#  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
#  enable_nat_gateway = true
#  single_nat_gateway = true
#  create_igw = true
#  map_public_ip_on_launch = true
#  tags = {
#    Terraform = "true"
#    Environment = "dev"
#  }
#}
##subnet tagging requirement for ELB
##https://docs.aws.amazon.com/eks/latest/userguide/network_reqs.html
#resource "null_resource" "add_custom_tags_to_public_subnet" {
#  triggers = {
#    always_run = "${timestamp()}"
#  }
#  provisioner "local-exec" {
#    command = <<EOF
#aws ec2 create-tags --resources ${module.vpc.public_subnets[0]} --tags "Key=kubernetes.io/role/elb, Value=1"
#aws ec2 create-tags --resources ${module.vpc.public_subnets[0]} --tags "Key=kubernetes.io/cluster/${var.cluster_name}, Value=shared"
#EOF
#  }
#  depends_on = [
#    module.vpc.public_subnets
#  ]
#}