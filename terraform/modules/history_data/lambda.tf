# # Create a zip file from the code in code/index.js
# provider "zipper" {
#   skip_ssl_validation = false
# }

# resource "zipper_file" "zip_file" {
#   type               = "local" # put "git" when using github repo
#   source             = "modules/history_data/code/index.js"
#   output_path        = "modules/history_data/code/function.zip"
#   not_when_nonexists = false
# }

# Create the lambda function
resource "aws_lambda_function" "history_data_function" {
  function_name                  = "${var.project}-${var.environment}-history_data_function"
  role                           = aws_iam_role.iam_lambda_role.arn
  handler                        = "index.js"
  filename                       = "../../modules/history_data/code/function.zip"
  runtime                        = "nodejs12.x"
  memory_size                    = 128 # default value
  reserved_concurrent_executions = 10
  dead_letter_config {
    target_arn = aws_sqs_queue.lamabda_function_queue.arn
  }

  environment {
    variables = {
      BUCKET_NAME = aws_s3_bucket.lamabda_function_bucket.bucket
    }

  }
}

# For sqs invokations

resource "aws_lambda_function_event_invoke_config" "dead_letter_queue" {
  function_name                = aws_lambda_function.history_data_function.function_name
  qualifier                    = "$LATEST"
  maximum_event_age_in_seconds = 21600
  maximum_retry_attempts       = 2

  # destination_config {
  #   on_failure {
  #     destination = aws_sqs_queue.lamabda_function_queue.arn
  #   }
  # }
}

resource "aws_lambda_event_source_mapping" "sqs_trigger" {
  event_source_arn = aws_sqs_queue.lamabda_function_queue.arn
  function_name    = aws_lambda_function.history_data_function.arn
}