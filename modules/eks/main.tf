resource "aws_eks_cluster" "services_cluster" {
  name     = "services_cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn
  vpc_config {
    subnet_ids = var.private_subnet_ids[*]
    security_group_ids = [var.security_group_id]
  }
}

resource "aws_eks_node_group" "services_nodes" {
  cluster_name    = aws_eks_cluster.services_cluster.name
  node_group_name = "my-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn

  launch_template {
    id = aws_launch_template.eks_launch_template.id
    version = "$Latest"
  }

  # TODO: extend this for future scalability
  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  subnet_ids = var.private_subnet_ids[*]
}

resource "aws_iam_role" "eks_cluster_role" {
  name = "eks_cluster_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role" "eks_node_role" {
  name = "eks_node_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_launch_template" "eks_launch_template" {
  name_prefix = "eks-node-launch-template-"
  // Define your EC2 instance configuration here
  // Example: instance_type, AMI, key_name, user_data, etc.
  instance_type = "t2.micro"

}