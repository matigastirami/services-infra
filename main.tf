locals {
  tags = {
    environment = "development"
    terraform   = true
  }
  vpc_cidr_block = "10.0.0.0/16"
}

module "services_vpc" {
  source         = "./modules/vpc"
  tags           = local.tags
  vpc_cidr_block = local.vpc_cidr_block
}

module "security_group" {
  source                 = "./modules/security_group"
  vpc_id                 = module.services_vpc.vpc_id
  tags                   = local.tags
  eks_cluster_cidr_block = local.vpc_cidr_block
}

module "eks_cluster" {
  source             = "./modules/eks"
  private_subnet_ids = module.services_vpc.private_subnets_ids
  security_group_id  = module.services_vpc.vpc_sec_group_id
}

module "ecr_repositories" {
  source = "./modules/ecr"
}

#module "cicd_tools_jenkins" {
#  source = "./modules/jenkins",
#  namespace = "cicd-tools",
#  jenkins_chart_version = "4.6.5"
#}

#module "dev_free_tier_mongodb" {
#  source = "./modules/mongodb_atlas"
#  mongo_db_atlas_configuration = {
#    mongo_db_atlas_project_name: "services-project",
#    mongo_db_organization_id: "5a0f19594e658110663ae8da",
#    mongo_db_cluster_name: "services-cluster"
#  }
#}