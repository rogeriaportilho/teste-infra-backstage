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
