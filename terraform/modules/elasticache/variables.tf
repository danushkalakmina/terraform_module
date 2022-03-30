variable "Project" {
  type        = string
}

variable "Environment" {
  type        = string
}

variable "VpcId" {
  type        = string
  description = "id of the vpc"
}

variable "PrivateSubnets" {
  type = set(string)
}
# variable "PrivateSubnet1" {
#   type        = string
# }

# variable "PrivateSubnet2" {
#   type        = string
# }
variable "Azs" {
  type = list(string)
  default = [ "us-east-1a", "us-east-1b" ]
}

variable "NodeType" {
  type = string
  default = "cache.t2.micro"
}

variable "MaintenanceWindow" {
  type = string
  default = "sun:22:00-sun:23:00"
}
variable "SnapshotWindow" {
  type = string
  default = "23:00-00:00"
}

variable "SecurityGroupIngressCidrBlocks" {
  type = list(string)
  default = [ "0.0.0.0/0" ]
}
