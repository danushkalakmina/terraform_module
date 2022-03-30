resource "aws_sqs_queue" "SqsQueue" {
  name                      = "${var.Project}-${var.Environment}-${var.QueueName}"
  max_message_size          = var.MaxMsgSize
  message_retention_seconds = var.MsgRetentionSeconds
}