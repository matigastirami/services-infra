variable "mongodb_ip_access_list" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "cidr block"
}

variable "mongodb_db_credentials" {
  type = map(string)
  default = {
    username : "services-dev-user"
    password : "services-dev-pass" # TODO: how to use secrets manager here instead of providing a random one?
  }
  description = "Name of the mongodb cluster"
}

variable "mongo_db_atlas_configuration" {
  description = "Configuration for the mongodb atlas cluster and db"
  type = object({
    mongo_db_atlas_project_name = optional(string, "no-project-name-specified"),
    mongo_db_organization_id    = string,
    mongo_db_cluster_name       = optional(string, "no-cluster-name-specified")
  })
}