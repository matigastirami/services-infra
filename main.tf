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
  source = "./modules/security_group"
  vpc_id = module.services_vpc.vpc_id
  tags   = local.tags
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