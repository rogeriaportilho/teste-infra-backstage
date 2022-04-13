variable "aws_region" {
  type        = string
  description = "AWS region used for all resources"
  default     = "us-east-1"
}

variable "domain_name" {
  type = string
  description = "Domain name to hosted Backstage"
  default = "empcbr.thoughtworks-labs.net"
}