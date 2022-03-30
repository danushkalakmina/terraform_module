resource "aws_sqs_queue" "lamabda_function_queue" {
  name                      = "${var.project}-${var.environment}-history-data-lambda"
  max_message_size          = 262144 # 256 KiB in bytes
  message_retention_seconds = 86400 # 1 day in seconds
}