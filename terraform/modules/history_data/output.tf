output "lambda_function_arn" {
  description = "arn of the lambda function"
  value       = aws_lambda_function.history_data_function.arn
}