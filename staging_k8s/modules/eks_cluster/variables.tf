variable "project" {
  type        = string
  description = "Name of project this VPC is meant to house"
}

variable "environment" {
  type        = string
  description = "Name of environment this VPC is targeting"
}

variable "vpcId" {
  type = string
  description = "vpc id"
}

# variable "security_groups" {
#   type = set(string)
#   description = "additional security groups"
# }

variable "cluster_name" {
  type        = string
  description = "Name of the eks cluster"
}

variable "private_subnet_1_id" {
  type = string
}

variable "private_subnet_2_id" {
  type = string
}

variable "public_subnet_1_id" {
  type = string
}

variable "public_subnet_2_id" {
  type = string
}