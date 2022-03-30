terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.1.0"
    }
    mongodbatlas = {
      source  = "mongodb/mongodbatlas"
      version = "1.2.0"
    }
    # zipper = {
    #   source  = "arthurhlt/zipper"
    #   version = "0.14.0"
    # }
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Managed_by  = "Terraform"
      Project     = "Trender"
      Environment = "Prod"
    }
  }
}

provider "mongodbatlas" {
  public_key  = "jzdpiypl"
  private_key = "e346f9e2-74c6-47a1-abbc-b144e16d4324"
}