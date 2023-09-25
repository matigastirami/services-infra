variable "vpc_ids" {
  description = "IDs of the VPC this EKS cluster belongs to"
  type = list(string)
}