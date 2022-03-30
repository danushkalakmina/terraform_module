variable "Project" {
  type = string
}

variable "Environment" {
  type = string
}

variable "VpcId" {
  type        = string
  description = "ID of the vpc"
}

variable "PublicSubnet1" {
  type = string
}

variable "PublicSubnet2" {
  type = string
}

variable "DomainName" {
  type = string
}
