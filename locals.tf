data "aws_availability_zones" "available" {
  state = "available"
}
locals {
  # create a name like 'atlas-eks-dev-1-27'
  env_name = "${var.project_name}-${var.environment}-${replace(var.eks_version, ".", "-")}"
}