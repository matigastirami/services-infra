resource "mongodbatlas_project" "mongo_project" {
  name   = var.mongodb_project_name
  org_id = var.mongodb_organization_id
}

resource "mongodbatlas_cluster" "mongo_cluster" {
  name = var.mongodb_cluster_name
  project_id = mongodbatlas_project.mongo_project.id
  # Provide shared cluster (free tier M0 instance)
  provider_instance_size_name = "M0"
  provider_name = "TENANT"
  backing_provider_name = "AWS"
  provider_region_name = "US_EAST_1"
}

resource "mongodbatlas_database_user" "mongo_user" {
  project_id = mongodbatlas_project.mongo_project.id
  username   = var.mongodb_db_credentials.username
  password = var.mongodb_db_credentials.password
}