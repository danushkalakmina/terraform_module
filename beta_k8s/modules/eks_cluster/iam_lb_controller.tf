# Creating the lb controller policty
resource "aws_iam_policy" "lb_controller_policy" {
  name        = "${var.cluster_name}-LBControllerPolicy"
  path        = "/"
  description = "${var.cluster_name}-LBControllerPolicy"
  policy      = file("${path.module}/iam_lb_controller_policy.json")
}

data "aws_iam_policy_document" "assume_role_policy_lb_controller" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.IAM_OIDC_provider.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-load-balancer-controller"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.IAM_OIDC_provider.arn]
      type        = "Federated"
    }
  }
}

# iam role for lb
resource "aws_iam_role" "lb_controller_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy_lb_controller.json
  name               = "${var.cluster_name}-LBControllerRole"
}

resource "aws_iam_role_policy_attachment" "lb_controller_role_policy_attachment" {
  policy_arn = aws_iam_policy.lb_controller_policy.arn
  role       = aws_iam_role.lb_controller_role.name
}