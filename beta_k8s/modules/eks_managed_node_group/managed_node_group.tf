resource "aws_eks_node_group" "example" {
  cluster_name    = var.eks_cluster_name
  node_group_name = "${var.eks_cluster_name}_${var.node_group_name}"
  node_role_arn   = aws_iam_role.node_group_iam_role.arn
  # subnet_ids      = [aws_subnet.private_subnet_1_id.id, aws_subnet.private_subnet_2_id.id] 
  subnet_ids = var.subnet_ids


  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  remote_access {
    ec2_ssh_key = "TrenderTag-k8s-BETA"
  }

  update_config {
    max_unavailable = var.max_unavailable
  }

  disk_size              = var.disk_size
  instance_types         = var.instance_types
  # node_group_name_prefix = var.node_group_name_prefix

  tags = {
    cluster_name    = var.eks_cluster_name
    node_group_name = var.node_group_name
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  # depends_on = [
  #   aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
  #   aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
  #   aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
  # ]
}