data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  # create a name like 'atlas-eks-dev-1-27'
  env_name = "REPLACE_ME_WITH_VARIABLES"
}

module "subnet_addrs" {
  source  = "hashicorp/subnets/cidr"
  version = "1.0.0"
  base_cidr_block = var.vpc_params.vpc_cidr
  networks = [
    {
      name     = "public-1"
      new_bits = 4
    },
    {
      name     = "public-2"
      new_bits = 4
    },
    {
      name     = "private-1"
      new_bits = 4
    },
    {
      name     = "private-2"
      new_bits = 4
    },
    {
      name     = "intra-1"
      new_bits = 8
    },
    {
      name     = "intra-2"
      new_bits = 8
    },
  ]
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.1.1"
  name = "${local.env_name}-vpc"
  cidr = var.vpc_params.vpc_cidr
  azs = data.aws_availability_zones.available.names
  putin_khuylo = true
  public_subnets  = [module.subnet_addrs.network_cidr_blocks["public-1"], module.subnet_addrs.network_cidr_blocks["public-2"]]
  private_subnets = [module.subnet_addrs.network_cidr_blocks["private-1"], module.subnet_addrs.network_cidr_blocks["private-2"]]
  intra_subnets   = [module.subnet_addrs.network_cidr_blocks["intra-1"], module.subnet_addrs.network_cidr_blocks["intra-2"]]
  enable_nat_gateway = var.vpc_params.enable_nat_gateway
  enable_vpn_gateway = var.vpc_params.enable_vpn_gateway
  enable_flow_log = var.vpc_params.enable_flow_log
}