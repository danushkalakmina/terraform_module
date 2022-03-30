variable "project" {
  type        = string
  description = "Name of project this VPC is meant to house"
}

variable "environment" {
  type        = string
  description = "Name of environment this VPC is targeting"
}

variable "domain_name" {
  type        = string
  description = "domain name"
}

variable "bucket_website_endpoint" {
  type        = string
  description = "bucket website endpoint"
}
