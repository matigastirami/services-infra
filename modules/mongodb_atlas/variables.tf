variable "mongodb_project_name" {
  type = string
  default = "services-dev-project"
  description = "Name of the project in mongodb atlas"
}

variable "mongodb_organization_id" {
  type = string
  description = "Name of the mongodb atlas organization (Mandatory)"
  default = "5a0f19594e658110663ae8da"
}

variable "mongodb_cluster_name" {
  type = string
  default = "services-dev-cluster"
  description = "Name of the mongodb cluster"
}

variable "mongodb_ip_access_list" {
  type = list(string)
  default = ["0.0.0.0/0"],
}

variable "mongodb_db_credentials" {
  type = map(string)
  default = {
    username: "services-dev-user"
    password: "services-dev-user" # TODO: how to use secrets manager here?
  }
  description = "Name of the mongodb cluster"
}