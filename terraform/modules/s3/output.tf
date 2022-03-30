output "S3_BucketArn" {
  value = aws_s3_bucket.S3_Bucket.arn
}
output "S3_BucketName" {
  value = aws_s3_bucket.S3_Bucket.id
}
# output "bucket_website_endpoint" {
#   description = "bucket website end point"
#   value       = aws_s3_bucket.front_end_bucket.website_endpoint
# }
