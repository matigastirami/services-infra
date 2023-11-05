resource "aws_eks_cluster" "services_cluster" {
  name     = "services_cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn
  vpc_config {
    subnet_ids         = var.private_subnet_ids
    security_group_ids = [var.security_group_id]
    endpoint_private_access = true
    endpoint_public_access = true
  }
  enabled_cluster_log_types = ["api", "audit"]
  depends_on = [
    aws_iam_policy_attachment.eks_cluster_policy_attachment
  ]
}

resource "aws_eks_node_group" "services_nodes" {
  cluster_name    = aws_eks_cluster.services_cluster.name
  node_group_name = "${aws_eks_cluster.services_cluster.name}-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  launch_template {
    id      = aws_launch_template.eks_launch_template.id
    version = "$Latest"
  }
  # TODO: extend this for future scalability
  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }
  subnet_ids = flatten(var.private_subnet_ids)
  depends_on = [
    aws_iam_policy_attachment.ecr_read_only_policy_attachment,
    aws_iam_policy_attachment.eks_worker_node_policy_attachment,
    aws_iam_role_policy_attachment.eks_cni_policy_attachment
  ]
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

resource "aws_iam_policy_attachment" "eks_cluster_policy_attachment" {
  name       = "AmazonEKSClusterPolicy"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  roles      = [aws_iam_role.eks_cluster_role.name]
}

resource "aws_iam_policy_attachment" "eks_worker_node_policy_attachment" {
  name       = "AmazonEKSWorkerNodePolicy"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  roles      = [aws_iam_role.eks_node_role.name]
}

resource "aws_iam_policy_attachment" "ecr_read_only_policy_attachment" {
  name       = "AmazonEC2ContainerRegistryReadOnly"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  roles      = [aws_iam_role.eks_node_role.name]
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_role.name
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
  image_id      = "ami-03a6eaae9938c858c"
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 20 # Adjust the volume size as needed
      volume_type = "gp2"
    }
  }
  network_interfaces {
    associate_public_ip_address = true # Enable if you want public IP addresses
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "eks-node"
      # Add more tags as needed
    }
  }
  user_data = base64encode(templatefile("${path.module}/templates/configure-ec2.tpl", {
    EKS_CLUSTER_NAME = aws_eks_cluster.services_cluster.name
    API_SERVER_URL = aws_eks_cluster.services_cluster.endpoint
    B64_CLUSTER_CA = aws_eks_cluster.services_cluster.certificate_authority[0].data
  }))
}

resource "aws_cloudwatch_log_group" "eks_api_logs" {
  # The log group name format is /aws/eks/<cluster-name>/cluster
  # Reference: https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html
  name              = "/aws/eks/${aws_eks_cluster.services_cluster.name}/cluster"
  retention_in_days = 1
  skip_destroy      = false
}

# Create a log group with the instance ID in the name
resource "aws_cloudwatch_log_group" "instance_log_group" {
  name = "/aws/ec2/${aws_eks_node_group.services_nodes.id}"
}