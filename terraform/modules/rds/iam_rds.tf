# Create policies and roles for RDS 
data "aws_iam_policy_document" "rds-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["rds.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "iam_rds_role" {
  name               = "${var.project}-${var.environment}-rds-role"
  path               = "/system/"
  assume_role_policy = data.aws_iam_policy_document.rds-assume-role-policy.json
}

data "template_file" "rds_policy_data" {
  template = file("${path.module}/iam_policy/rds_policy.json")
  vars = {
    lambda_function_arn = var.lambda_function_arn
  }
}

resource "aws_iam_policy" "rds_policy" {
  name        = "${var.project}-${var.environment}-rds-policy"
  description = "${var.project}-${var.environment}-rds-policy"
  # policy      = "${file("modules/history_data/iam_policies/rds_policy.json")}"
  policy = data.template_file.rds_policy_data.rendered
}

resource "aws_iam_policy_attachment" "rds_policty_attachment" {
  name       = "rds_policty_attachment"
  roles      = ["${aws_iam_role.iam_rds_role.name}"]
  policy_arn = aws_iam_policy.rds_policy.arn
}
