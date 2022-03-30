output "HistoryDataLambdaFunctionArn" {
  description = "arn of the lambda function"
  value       = aws_lambda_function.HistoryDataLambdaFunction.arn
}