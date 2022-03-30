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
resource "aws_lambda_function" "HistoryDataLambdaFunction" {
  function_name                  = "${var.Project}-${var.Environment}-HistoryDataLambdaFunction"
  role                           = aws_iam_role.HisotryDataIamLambdaRole.arn
  handler                        = "index.js"
  filename                       = "../../modules/history_data/code/function.zip"
  runtime                        = "nodejs12.x"
  memory_size                    = 128 # default value
  reserved_concurrent_executions = 10
  dead_letter_config {
    target_arn = var.SqsQueueArn
  }

  environment {
    variables = {
      BUCKET_NAME = var.S3_BucketName
    }

  }
}

# For sqs invokations

resource "aws_lambda_function_event_invoke_config" "DeadLetterQueueConfig" {
  function_name                = aws_lambda_function.HistoryDataLambdaFunction.function_name
  qualifier                    = "$LATEST"
  maximum_event_age_in_seconds = 21600
  maximum_retry_attempts       = 2

  # destination_config {
  #   on_failure {
  #     destination = aws_sqs_queue.lamabda_function_queue.arn
  #   }
  # }
}

resource "aws_lambda_event_source_mapping" "SqsTrigger" {
  event_source_arn = var.SqsQueueArn
  function_name    = aws_lambda_function.HistoryDataLambdaFunction.arn
}
