
variable "zone_id" {
  type        = string
  description = "dns hosted zone id"
  default     = "Z097864524JG2W9IXIRVD"
}

variable "domain_name" {
  type        = string
  description = "domain name"
  default     = "sadaham.me"
}

variable "aws_region" {
  type        = string
  description = "domain name"
  default     = "us-east-1"
}

variable "sns_email" {
  type        = string
  description = "the email address that topic subscribed to"
  default = "sadaham.r@aeturnum.com"
}

variable "Project" {
  type        = string
  description = "Name of project this VPC is meant to house"
}

