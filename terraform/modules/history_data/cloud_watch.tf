resource "aws_cloudwatch_log_group" "lamabda_function_log_group" {
  name = "${var.project}-${var.environment}-lamabda-function-log-group"
}
