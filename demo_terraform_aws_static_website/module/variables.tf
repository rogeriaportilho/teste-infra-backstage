variable "aws_region" {
  description = "Type AWS Region"
  default     = "AWS region"
}

variable "domain_name" {
  description = "For DNS domain"
  default     = "DNS domain name"
}

variable "bucket_name" {
  description = "For bucket name"
  default     = "Bucket name"
}

variable "tags" {
  description = "Tags added to resources"
  default     = {}
  type        = map(string)
}

variable "support-spa" {
  description = "Support SPA (Single-Page Application) website with redirect to index.html"
  default     = false
  type        = bool
}