#module "dev_free_tier_mongodb" {
#  source = "./modules/mongodb_atlas"
#  mongo_db_atlas_configuration = {
#    mongo_db_atlas_project_name: "services-project",
#    mongo_db_organization_id: "5a0f19594e658110663ae8da",
#    mongo_db_cluster_name: "services-cluster"
#  }
#}

module "vpc" {
  source = "./modules/vpc"
  vpc_params = {
    vpc_cidr               = "10.1.0.0/16"
    enable_nat_gateway     = true
    one_nat_gateway_per_az = true
    single_nat_gateway     = false
    enable_vpn_gateway     = false
    enable_flow_log        = false
  }
}

# Here I would put a configuration for VPC, SG and EKS cluster, if I'd have one!!!!