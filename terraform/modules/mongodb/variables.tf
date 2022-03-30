
variable "ATLAS_PROJECT_ID" {
  type        = string
  description = "the atlas project id"
}

variable "ATLAS_PROVIDER" {
  type        = string
  description = "the cloud provider to create atlas cluster"
  default     = "AWS"
}

variable "ATLAS_VPC_CIDR" {
  default = "192.168.248.0/21"
  type    = string
}


variable "AWS_ACCOUNT_ID" {
  type = string
}

variable "AWS_VPC_CIDR" {
  type = string
}

variable "CONTAINER_ID" {
  type = string
  description = "CONTAINER_ID"
}

variable "AWS_VPC_ID" {
  type = string
  description = "AWS_VPC_ID"
}

# route tables

variable public_route_id {
  type = string
}

variable private_route_1_id {
  type = string
}

variable private_route_2_id {
  type = string
}