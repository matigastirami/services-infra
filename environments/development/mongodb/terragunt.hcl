terraform {
  source = "../../../modules/mongodb_atlas"
}

include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path = find_in_parent_folders("env.hcl")
  expose = true
  merge_strategy = "no_merge"
}

inputs = {
  source = "../../../modules/mongodb_atlas"
  mongodb_ip_access_list = ["0.0.0.0/0"]
  mongo_db_atlas_configuration = {
    mongo_db_atlas_project_name = "mongodb_project_dev"
    mongo_db_cluster_name = "mongodb_cluster_dev"
    mongo_db_organization_id = "REPLACE_ME"
  }
}