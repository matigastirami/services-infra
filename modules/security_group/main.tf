resource "aws_security_group" "eks_sg" {
  name        = "eks_sg"
  description = "EKS Security Group"

  // Add your security group rules here
}