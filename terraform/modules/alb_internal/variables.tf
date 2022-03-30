variable "Project" {
  type        = string
}

variable "Environment" {
  type        = string
}

variable "VpcId" {
  type        = string
  description = "ID of the vpc"
}

variable "PrivateSubnet1" {
  type        = string
}

variable "PrivateSubnet2" {
  type        = string
}