variable "Project" {
    type = string
}

variable "Environment" {
  type = string
}
variable "LogGroupName" {
  type = string
}

variable "LogRetentionDays" {
  type = number
  description = "Number of days to retain logs"
  default = 30
}