variable "Project" {
  type = string
}

variable "VpcId" {
  type = string
}

variable "Environment" {
  type = string
}

variable "VpcCidr" {
  type = string
}

variable "PrivateSubnets" {
  type = set(string)
}

variable "MqUsername" {
  type        = string
  default     = "mqadmin"
  description = "Login username of the RabbitMQ cluster"
}
