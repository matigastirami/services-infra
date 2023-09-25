variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

# TODO: move to a safe place as setting for example: MONGODB_ATLAS_PUBLIC_KEY and MONGODB_ATLAS_PRIVATE_KEY or using aws secrets manager
variable "mongodb_atlas_keys" {
  type = map(string)
  default = {
    public_key : "rabmlvaw",
    private_key : "c2c3579d-40bb-4da2-bae9-b468a4b907a6"
  }
  description = "Name of the project in mongodb atlas"
}