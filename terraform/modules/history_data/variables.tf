variable "project" {
  type        = string
  description = "Name of project this VPC is meant to house"
}

variable "environment" {
  type        = string
  description = "Name of environment this VPC is targeting"
}

variable "account_number" {
  type        = string
  description = "Name of the aws account number"
}

variable "region" {
  type        = string
  description = "Name of aws region"
}