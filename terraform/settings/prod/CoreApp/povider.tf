terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.74.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Managed_by  = "Terraform"
      project     = "TrenderTag"
      environment = "DevOps"
    }
  }
}

locals {
  account_number = "105757358087"
  project        = "trendertag"
  environment    = "devops"
  region         = "us-east-1"
}