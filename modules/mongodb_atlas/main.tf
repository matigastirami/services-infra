resource "mongodbatlas_project" "mongo_project" {
  name   = var.mongo_db_atlas_configuration.mongo_db_atlas_project_name
  org_id = var.mongo_db_atlas_configuration.mongo_db_organization_id
}

# TODO: create private link between atlas vpc and services VPC (once the eks is ready)
resource "mongodbatlas_cluster" "mongo_cluster" {
  name       = var.mongo_db_atlas_configuration.mongo_db_cluster_name
  project_id = mongodbatlas_project.mongo_project.id
  # Provide shared cluster (free tier M0 instance, for dev env preferably)
  cluster_type                = "REPLICASET"
  provider_instance_size_name = "M0"
  provider_name               = "TENANT"
  backing_provider_name       = "AWS"
  provider_region_name        = "US_EAST_1"
}

resource "mongodbatlas_database_user" "mongo_user" {
  project_id         = mongodbatlas_project.mongo_project.id
  username           = var.mongodb_db_credentials.username
  password           = random_password.mongodb-user-password.result
  auth_database_name = "admin"
  roles {
    role_name     = "readWrite"
    database_name = "${var.mongo_db_atlas_configuration.mongo_db_atlas_project_name}-db"
  }
}

resource "random_password" "mongodb-user-password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

# Whitelist all the IPs passed in the variables
resource "mongodbatlas_project_ip_access_list" "mongo_access_list" {
  project_id = mongodbatlas_project.mongo_project.id
  count      = length(var.mongodb_ip_access_list)
  cidr_block = var.mongodb_ip_access_list[count.index]
  comment    = "What IPs can reach the database server"
}