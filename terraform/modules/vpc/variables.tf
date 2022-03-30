variable "Project" {
  type        = string
  default = "Trender"
}

variable "Environment" {
  type        = string
  default = "Devops"
}

variable "CidrBlock" {
  type = string
}

variable "PublicSubnet1_Block" {
  type = string
}

variable "AzPublicSubnet1" {
  type = string
}

variable "PublicSubnet2_Block" {
  type = string
}

variable "AzPublicSubnet2" {
  type = string
}

variable "PrivateSubnet1_Block" {
  type = string
}

variable "AzPrivateSubnet1" {
  type = string
}

variable "PrivateSubnet2_Block" {
  type = string
}

variable "AzPrivateSubnet2" {
  type = string
}


variable "K8sClusterName" {
  type = string
  description = "This variables needs to tag subets with EKS cluster names."
}

# variable "public_subnet_1" {
#   type = string
# }
# variable "PublicSubnet1" {
#   type = string
# }

# variable "public_subnet_1_block" {
#   type = string
# }

# variable "public_subnet_2" {
#   type = string
# }

# variable "public_subnet_2_block" {
#   type = string
# }
# variable "private_subnet_1" {
#   type = string
# }

# variable "private_subnet_1_block" {
#   type = string
# }

# variable "private_subnet_2" {
#   type = string
# }

# variable "private_subnet_2_block" {
#   type = string
# }

# # for k8s subnet tagging
# variable "k8s_cluster_name" {
#   type = string
# }