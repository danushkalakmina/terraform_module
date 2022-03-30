# vpc data sources
data "aws_vpc" "trender_vpc" {
  tags = {
    project     = "TrenderTag"
    environment = "DevOps"
  }
}

data "aws_subnet" "private_subnet_1" {
  filter {
    name   = "tag:Name"
    values = ["private_subnet_1"]
  }
}


data "aws_subnet" "private_subnet_2" {
  filter {
    name   = "tag:Name"
    values = ["private_subnet_2"]
  }
}

data "aws_subnet" "public_subnet_1" {
  filter {
    name   = "tag:Name"
    values = ["public_subnet_1"]
  }
}

data "aws_subnet" "public_subnet_2" {
  filter {
    name   = "tag:Name"
    values = ["public_subnet_2"]
  }
}

# getting load balancer details

data "aws_lb" "public_alb" {
  tags = {
    visibility = "public"
  }
}

data "aws_lb" "internal_alb" {
  tags = {
    visibility = "internal"
  }
}

# getting iam instance profile

data "aws_iam_instance_profile" "iam_profile" {
  name = "${var.project}-${var.environment}-instance-profile"
}