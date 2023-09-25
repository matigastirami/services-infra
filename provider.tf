provider "aws" {
  region = "us-east-1" # Replace with your desired AWS region
}

provider "mongodbatlas" {
  private_key = var.mongodb_atlas_keys.private_key
  public_key  = var.mongodb_atlas_keys.public_key
}