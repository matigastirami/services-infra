output "atlas_cluster_connection_string" {
  value = mongodbatlas_cluster.mongo_cluster.connection_strings.0.standard_srv
}

output "ip_access_list" {
  value = mongodbatlas_project_ip_access_list.mongo_access_list[*].cidr_block
}

output "project_name" {
  value = mongodbatlas_project.mongo_project.name
}

output "username" {
  value = mongodbatlas_database_user.mongo_user.username
}

output "user_password" {
  sensitive = true
  value = mongodbatlas_database_user.mongo_user.password
}