resource "aws_iam_role" "eks" {
  name = "${var.env}-${var.eks_name}-eks-cluster"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazon.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

// Attach policy to allow EKS to create EC2 instances and load balancers
resource "aws_iam_role_policy_attachment" "eks" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSCusterPolicy"
  role       = aws_iam_role.eks.name
}

resource "aws_eks_cluster" "this" {
  name     = "${var.env}-${var.eks_name}"
  role_arn = aws_iam_role.eks.arn
  version = var.eks_version

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access = true
    subnet_ids = var.subnet_ids
  }
}