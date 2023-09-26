output "eks_cidr_block" {
  value = aws_eks_cluster.services_cluster.endpoint #TODO: check how to get this value
}