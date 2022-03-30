resource "aws_s3_bucket" "lamabda_function_bucket" {
  bucket = lower("${var.project}-${var.environment}-history-data-lambda")
  # acl    = "private"

  # versioning {
  #   enabled = true
  # }
}
