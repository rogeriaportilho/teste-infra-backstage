# Default Provider for AWS
provider "aws" {
  region = var.aws_region
}

terraform {
  required_providers {
    aws = {
      version = "~> 4.0"
    }
  }
}

module "aws_static_website" {
  source = "../../"
  
  # This is the bucekt name that's releate the React App Name
  bucket_name = var.bucket_name

  # This is the domain as defined in Route53
  domain_name = var.domain_name
}