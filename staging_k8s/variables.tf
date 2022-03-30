# locals
variable "account_number" {
    type = string
}

variable "project" {
  type = string
  default = "TrenderTag"
}

variable "environment" {
  type = string
  default = "dev"
}

variable "region" {
  type = string
  default = "us-east-1"
}

# vpc

# eks_cluster

variable "cluster_name" {
    type = string
    default = "k8sCluster"
}