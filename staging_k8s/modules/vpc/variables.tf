variable "project" {
  type        = string
  description = "Name of project this VPC is meant to house"
}

variable "environment" {
  type        = string
  description = "Name of environment this VPC is targeting"
}

variable "cidr_block" {
  type = string
}

variable "public_subnet_1" {
  type = string
}

variable "public_subnet_1_block" {
  type = string
}

variable "public_subnet_2" {
  type = string
}

variable "public_subnet_2_block" {
  type = string
}
variable "private_subnet_1" {
  type = string
}

variable "private_subnet_1_block" {
  type = string
}

variable "private_subnet_2" {
  type = string
}

variable "private_subnet_2_block" {
  type = string
}

# for k8s subnet tagging
variable "k8s_cluster_name" {
  type = string
}

# peering
variable "account_number" {
  type = string
}