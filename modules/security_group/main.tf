resource "aws_security_group" "eks_sg" {
  name        = "eks_sg"
  description = "EKS Security Group"
  tags = var.tags
  vpc_id = ""
}

resource "aws_security_group_rule" "eks_intra_cluster" {
  type        = "ingress"
  from_port   = 0 # Allow all ports for intra-cluster communication
  to_port     = 65535 # TODO: Adjust the port range as needed
  protocol    = "tcp" # TODO: Adjust the port range as needed
  cidr_blocks = ["<CIDR_BLOCK_OF_EKS_CLUSTER>"] # Replace with your EKS cluster CIDR block
  security_group_id = aws_security_group.eks_sg.id
}

resource "aws_security_group_rule" "eks_external_access" {
  type        = "ingress"
  from_port   = 0 # TODO: Adjust the port range as needed
  to_port     = 65535 # TODO: Adjust the port range as needed
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"] # Allow traffic from anywhere (restrict as needed)
  security_group_id = aws_security_group.eks_sg.id
}

resource "aws_security_group_rule" "eks_egress" {
  type        = "egress"
  from_port   = 0 # TODO: Adjust the port range as needed
  to_port     = 65535 # TODO: Adjust the port range as needed
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic (restrict as needed)
  security_group_id = aws_security_group.eks_sg.id
}