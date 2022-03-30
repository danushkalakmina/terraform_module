resource "aws_s3_bucket" "S3_Bucket" {
  bucket = lower("${var.Project}-${var.Environment}-${var.BucketName}")

  tags = {
    Name        = lower("${var.Project}-${var.Environment}-${var.BucketName}")
    Environment = var.Environment
  }
}

resource "aws_s3_bucket_acl" "EnablePrivateS3_BucketAcl" {
  # default to true
  count  = var.EnablePrivateS3_BucketAcl ? 1 : 0
  bucket = aws_s3_bucket.S3_Bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "EnableBlockPublicAccess" {
  # default to true
  count                   = var.EnableBlockPublicAccess ? 1 : 0
  bucket                  = aws_s3_bucket.S3_Bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "EnableS3_Versioning" {
  # default to false
  count  = var.EnableS3_Versioning ? 1 : 0
  bucket = aws_s3_bucket.S3_Bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}