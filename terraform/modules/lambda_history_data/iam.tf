data "aws_iam_policy_document" "LambdaAssumeRole" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "HisotryDataIamLambdaRole" {
  name               = "${var.Project}-${var.Environment}-HistoryDataLamdaRole"
  path               = "/system/"
  assume_role_policy = data.aws_iam_policy_document.LambdaAssumeRole.json
}

data "template_file" "HistoryDataLamdaPolicyJsonData" {
  template = file("${path.module}/iam_policies/lambda_policy.json")
  vars = {
    log_group_arn = var.CloudWatchLogGroupArn
    s3_bucket_arn = var.S3_BucketArn
    sqs_arn       = var.SqsQueueArn
    region        = var.AwsRegion
    account       = var.AwsAccountNumber
  }
}

resource "aws_iam_policy" "HistoryDataLamdaPolicy" {
  name        = "${var.Project}-${var.Environment}-HistoryDataLamdaPolicy"
  description = "${var.Project}-${var.Environment}-HistoryDataLamdaPolicy"
  policy      = data.template_file.HistoryDataLamdaPolicyJsonData.rendered
}

resource "aws_iam_policy_attachment" "LambdaPolicyAttachment" {
  name       = "LambdaPolicyAttachment"
  roles      = ["${aws_iam_role.HisotryDataIamLambdaRole.name}"]
  policy_arn = aws_iam_policy.HistoryDataLamdaPolicy.arn
}
