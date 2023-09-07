provider "aws" {
  region = "us-east-1" # Replace with your desired AWS region
}

// keys can also be configured using env variables MONGODB_ATLAS_PUBLIC_KEY and MONGODB_ATLAS_PRIVATE_KEY or using aws secrets manager
provider "mongodbatlas" {
  private_key = ""
  public_key = ""
}