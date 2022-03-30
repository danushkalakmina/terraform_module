data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.IAM_OIDC_provider.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.IAM_OIDC_provider.arn]
      type        = "Federated"
    }
  }
}

# for cni add on 
resource "aws_iam_role" "cni_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  name               = "${var.cluster_name}-CNIRole"
}

resource "aws_iam_role_policy_attachment" "cni_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.cni_role.name
}