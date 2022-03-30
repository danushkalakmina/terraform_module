# Creating the auto scaling policty
resource "aws_iam_policy" "auto_scaling_policy" {
  name        = "${var.cluster_name}_auto_scaller_policy"
  path        = "/"
  description = "${var.cluster_name}_auto_scaller_policy"
  policy = file("${path.module}/iam_autoscaler_policy.json")
}

data "aws_iam_policy_document" "assume_role_policy_autoscaler" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.IAM_OIDC_provider.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:cluster-autoscaler"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.IAM_OIDC_provider.arn]
      type        = "Federated"
    }
  }
}

# iam role for auto scaling
resource "aws_iam_role" "auto_scaling_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy_autoscaler.json
  name               = "${var.cluster_name}_auto_scaling_role"
}

resource "aws_iam_role_policy_attachment" "auto_scaling_role_policy_attachment" {
  policy_arn = aws_iam_policy.auto_scaling_policy.arn
  role       = aws_iam_role.auto_scaling_role.name
}