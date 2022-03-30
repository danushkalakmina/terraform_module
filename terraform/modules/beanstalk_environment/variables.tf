# Application and environment common variables
variable "project" {
  type        = string
  description = "Name of project this VPC is meant to house"
}

variable "environment" {
  type        = string
  description = "Name of environment this VPC is targeting"
}

variable "BeanstalkAppName" {
  type = string
  description = "Beanstalk application name created separately"
}

variable "service_name" {
  type        = string
  description = "Name of micro service"
}
# Route53 variables

variable "domain_name" {
  type        = string
  description = "domain name"
  default     = "trendertag.com"
}
variable "alb_dns_name" {
  type        = string
  description = "alb dns name"
}
variable "alb_zone_id" {
  type        = string
  description = "alb-zone-id"
}

# Environment variables

variable "stack_name" {
  type        = string
  description = "Solutions stack name"
}
# Options settings
# VPC settings
variable "vpcid" {
  type        = string
  description = "vpc id"
}
# variable "private_subnet_1" {
#   type        = string
#   description = "private subnet 1 id"
# }
variable "private_subnets" {
  type = list(string)
  description = "private subnet ids"
  
}
# variable "private_subnet_2" {
#   type        = string
#   description = "private subnet 2 id"
# }
variable "public_subnet_1" {
  type        = string
  description = "public subnet 2 id"
}

variable "public_subnet_2" {
  type        = string
  description = "public subnet 2 id"
}
# Options settings
# launch configuration
variable "EC2KeyName" {
  type        = string
  description = "EC2KeyName"
}
variable "iam_instance_profile" {
  type        = string
  description = "iam_instance_profile"
}
# Options settings
# instance configuration
variable "instanceType_1" {
  type        = string
  description = "ec2 instance type"
}
# variable "instanceType_2" {
#   type        = string
#   description = "ec2 instance type"
# }
# Options settings
# auto scaling settings settings
variable "MinSize" {
  type        = string
  description = "min size"
  default     = 1
}
variable "MaxSize" {
  type        = string
  description = "max size"
  default     = 2
}


# Options settings
# load balancer configuration
variable "shared_alb_arn" {
  type        = string
  description = "arn of the public load balancer"
}

# Options settings
# shared loadbalancer host rules/ listeners settings

# variable "host_header" {
#   type        = string
#   description = "url of the application"
# }

# Options settings
# health check path
variable "health_check_path" {
  type        = string
  description = "health check path"
}

# Options settings
# application specific environment veriables

variable "ENV" {
  type        = string
  description = "environment variable for the application environment"
}


# elb listener settings
variable "lb_port" {
  type        = string
  description = "environment variable for the application environment"
}