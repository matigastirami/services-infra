variable "env" {
  description = "Environment name"
  type = string
}

variable "eks_name" {
  description = "Name of the cluster"
  type = string
}

variable "enable_cluster_autoscaler" {
  description = "Should the cluster autoscaler be deployed?"
  type = bool
  default = false
}

variable "cluster_autoscaler_helm_version" {
  description = "Cluster autoscaler chart version"
  type = string
}

variable "openid_provider_arn" {
  default = "IAM OpenID connect provider ARN"
  type = string
}