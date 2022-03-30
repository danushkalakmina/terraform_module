data "aws_iam_policy_document" "lambda-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "iam_lambda_role" {
  name               = "${var.project}-${var.environment}-lambda-role"
  path               = "/system/"
  assume_role_policy = data.aws_iam_policy_document.lambda-assume-role-policy.json
}

data "template_file" "lambda_policy_data" {
  template = file("${path.module}/iam_policies/lambda_policy.json")
  vars = {
    log_group_arn = aws_cloudwatch_log_group.lamabda_function_log_group.arn
    s3_bucket_arn = aws_s3_bucket.lamabda_function_bucket.arn
    sqs_arn       = aws_sqs_queue.lamabda_function_queue.arn
    region        = var.region
    account       = var.account_number
  }
}

resource "aws_iam_policy" "policy" {
  name        = "${var.project}-${var.environment}-lambda-policy"
  description = "${var.project}-${var.environment}-lambda-policy"
  # policy      = "${file("modules/history_data/iam_policies/lambda_policy.json")}"
  policy = data.template_file.lambda_policy_data.rendered
}

resource "aws_iam_policy_attachment" "lambda_policy_attachment" {
  name       = "lambda_policy_attachment"
  roles      = ["${aws_iam_role.iam_lambda_role.name}"]
  policy_arn = aws_iam_policy.policy.arn
}
