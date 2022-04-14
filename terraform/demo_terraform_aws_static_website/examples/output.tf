output "cloudfront_distribution_id" {
  description = "The identifier for the distribution."
  value       = module.aws_static_website.cloudfront_distribution_id
}

output "cloudfront_distribution_arn" {
  description = "The ARN (Amazon Resource Name) for the distribution."
  value       = module.aws_static_website.cloudfront_distribution_arn
}

output "cloudfront_distribution_status" {
  description = "The current status of the distribution. Deployed if the distribution's information is fully propagated throughout the Amazon CloudFront system."
  value       = module.aws_static_website.cloudfront_distribution_status
}

output "cloudfront_distribution_domain_name" {
  description = "The domain name corresponding to the distribution."
  value       = module.aws_static_website.cloudfront_distribution_domain_name
}

output "s3_bucket_website_domain" {
  value = module.aws_static_website.s3_bucket_website_domain
}

output "aws_s3_bucket_id" {
  value = module.aws_static_website.aws_s3_bucket_id
}