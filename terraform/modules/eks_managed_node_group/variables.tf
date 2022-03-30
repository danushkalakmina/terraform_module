variable "eks_cluster_name" {
    type = string
}

variable "node_group_name" {
    type = string
    description = "the name of the node group to create"
}

# variable "node_role_arn" {
#     type = string
#     description = "iam role arn"
# }

variable "subnet_ids" {
    type = set(string)
    description = "subnet id's"
}

variable "desired_size" {
    type = number
    default = 2
}

variable "max_size" {
    type = number
    default = 10
}

variable "min_size" {
    type = number
    default = 1
}

variable "max_unavailable" {
    type = number
    default = 1
}

variable "disk_size" {
    type = number
    default = 1
}


variable "instance_types" {
    type = list(string)
    default = ["t3.large"]
}