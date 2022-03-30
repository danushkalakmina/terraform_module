terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.74.0"
    }
  }
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Managed_by  = "Terraform"
      project     = var.project
      environment = var.environment
    }
  }
}

locals {
  account_number = var.account_number
  project        = var.project
  environment    = var.environment
  region         = var.region
}