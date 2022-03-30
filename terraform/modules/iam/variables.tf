variable "Project" {
  type        = string
  description = "Name of project this VPC is meant to house"
}

variable "Environment" {
  type        = string
  description = "Name of environment this VPC is targeting"
}

# SES variables

variable "ses_send_email" {
  type        = string
  description = "the email address used by ses to send emails"
  default     = "no-reply@sadaham.me"
}

variable "domain_name" {
  type        = string
  description = "the domain name of email address"
  default     = "sadaham.me"
}

# S3 variables
variable "bucket_arn" {
  type        = string
  description = "arn of the s3 bucket"
}

