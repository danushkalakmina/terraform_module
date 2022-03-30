variable "project" {
  type        = string
  description = "Name of project this VPC is meant to house"
}

variable "environment" {
  type        = string
  description = "Name of environment this VPC is targeting"
}

variable "vpcid" {
  type        = string
  description = "id of the vpc"
}

variable "dbname" {
  type        = string
  description = "name of the database"
}

variable "db_version" {
  type        = string
  description = "version of the database"
}
variable "username" {
  type        = string
  description = "username"
  sensitive   = true
}
variable "password" {
  type        = string
  description = "password"
  sensitive   = true
}

variable "aurora_version" {
  type        = string
  description = "version of the db cluster"
  default     = "5.7.mysql_aurora.2.10.0"
}


variable "lambda_function_arn" {
  type        = string
  description = "the arn of the lambda function"
}
variable "private_subnet_1" {
  type        = string
  description = "private_subnets1 - id"
}

variable "private_subnet_2" {
  type        = string
  description = "private_subnets2 - id"
}
variable "instance_class" {
  type        = string
  description = "database instance class"
}