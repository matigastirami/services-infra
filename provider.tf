provider "aws" {
  region = "us-east-1"
  assume_role {
    role_arn = "arn:aws:iam::964716984557:role/tf-admin"
  }
  default_tags {
    tags = {
      component   = var.component
      created-by  = "terraform"
      environment = var.environment
    }
  }
}

provider "mongodbatlas" {
  private_key = var.mongodb_atlas_keys.private_key
  public_key  = var.mongodb_atlas_keys.public_key
}