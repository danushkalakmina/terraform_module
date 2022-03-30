
variable "Project" {
  type        = string
  description = "Name of project this VPC is meant to house"
}

variable "Environment" {
  type        = string
  description = "Name of environment this VPC is targeting"
}

variable "BucketName" {
  type    = string
}

# If-Else variables
variable "EnablePrivateS3_BucketAcl" {
  type    = bool
  default = true
}

variable "EnableBlockPublicAccess" {
  type    = bool
  default = true
}

variable "EnableS3_Versioning" {
  type    = bool
  default = false
}