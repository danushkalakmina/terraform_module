resource "aws_cloudwatch_log_group" "LogGroup" {
  name = "${var.Project}-${var.Environment}-${var.LogGroupName}"
  retention_in_days = var.LogRetentionDays
}