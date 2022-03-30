variable "Project" {
  type = string
}

variable "Environment" {
  type = string
}

variable "QueueName" {
  type = string
}

variable "MaxMsgSize" {
  type = number
  default = 262144
  description = "This is the default value of 256 KiB"
}

variable "MsgRetentionSeconds" {
  type = number
  default = 86400
  description = "This is the default value of 1 day"
}

