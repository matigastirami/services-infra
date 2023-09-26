locals {
  tags = {
    environment = "development"
    terraform   = true
  }
}
module "services_vpc" {
  source                = "./modules/vpc"
  private_subnets_count = 1
  public_subnets_count  = 1
  tags                  = local.tags
}

module "security_group" {
  source                 = "./modules/security_group"
  vpc_id                 = module.services_vpc.vpc_id
  tags                   = local.tags
  eks_cluster_cidr_block = module.services_vpc.vpc_cidr_block
}

module "eks_cluster" {
  source             = "./modules/eks"
  private_subnet_ids = module.services_vpc.private_subnets_ids
  security_group_id  = module.security_group.eks_security_group_id
}

#module "eks_cluster" {
#  source = "./modules/eks"
#}

#module "dev_free_tier_mongodb" {
#  source = "./modules/mongodb_atlas"
#  mongo_db_atlas_configuration = {
#    mongo_db_atlas_project_name: "services-project",
#    mongo_db_organization_id: "5a0f19594e658110663ae8da",
#    mongo_db_cluster_name: "services-cluster"
#  }
#}