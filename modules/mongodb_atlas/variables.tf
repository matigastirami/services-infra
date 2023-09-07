variable "mongodb_project_name" {
  type = string
  default = "services-dev-project"
  description = "Name of the project in mongodb atlas"
}

variable "mongodb_organization_id" {
  type = string
  description = "Name of the mongodb atlas organization (Mandatory)"
}

variable "mongodb_cluster_name" {
  type = string
  default = "services-dev-cluster"
  description = "Name of the mongodb cluster"
}

variable "mongodb_db_credentials" {
  type = map(string)
  default = {
    username: "services-dev-user"
    password: "services-dev-user" # TODO: how to use secrets manager here?
  }
  description = "Name of the mongodb cluster"
}