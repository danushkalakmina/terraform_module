resource "aws_eks_cluster" "eks_cluster" {
  # name     = "${var.project}-${var.environment}-k8sCluster"
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_iam_role.arn


  vpc_config {
    subnet_ids              = [var.private_subnet_1_id, var.private_subnet_2_id, var.public_subnet_1_id, var.public_subnet_2_id]
    endpoint_private_access = true
    endpoint_public_access  = true
    # security_group_ids      = [aws_security_group.allow_tls.id]
    public_access_cidrs = ["54.80.224.197/32"]

  }

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Ensure log group is also created before eks cluster creation
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
    aws_cloudwatch_log_group.eks_cloudwatch_log_group
  ]
}

output "endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}
