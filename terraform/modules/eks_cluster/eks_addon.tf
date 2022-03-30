resource "aws_eks_addon" "cni" {
  cluster_name             = aws_eks_cluster.eks_cluster.name
  addon_name               = "vpc-cni"
  service_account_role_arn = aws_iam_role.cni_role.arn
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name             = aws_eks_cluster.eks_cluster.name
  addon_name               = "kube-proxy"
}

resource "aws_eks_addon" "codeDNS" {
  cluster_name             = aws_eks_cluster.eks_cluster.name
  addon_name               = "coredns"
}