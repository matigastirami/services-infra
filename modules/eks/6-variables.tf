variable "env" {
  description = "Environment name"
  type = string
}

variable "eks_version" {
  description = "What version of K8s are you going to use?"
  type = string
}

variable "eks_name" {
  description = "Name of the cluster"
  type = string
}

variable "subnet_ids" {
  description = "List of subnet IDs. At lease 2 different AZs must be provided"
  type = list(string)
}

variable "node_iam_policies" {
  description = "List of IAM policies to attach to EKS-managed nodes"
  type = map(any)
  default = {
    1 = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    2 = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    3 = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    4 = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }
}

variable "node_groups" {
  description = "EKS node groups"
  type = object({
    general = object({
      capacity_type = string
      instance_type = list(string)
      scaling_config = object({
        desired_size = number
        max_size = number
        min_size = number
      })
    })
  })
}

variable "enable_irsa" {
  description = "Determines if an OpenID connect provider must be created"
  type = bool
  default = true
}