output "cloudfront_distribution_id" {
  description = "The identifier for the distribution."
  value       = element(concat(aws_cloudfront_distribution.website.*.id, [""]), 0)
}

output "cloudfront_distribution_arn" {
  description = "The ARN (Amazon Resource Name) for the distribution."
  value       = element(concat(aws_cloudfront_distribution.website.*.arn, [""]), 0)
}

output "cloudfront_distribution_caller_reference" {
  description = "Internal value used by CloudFront to allow future updates to the distribution configuration."
  value       = element(concat(aws_cloudfront_distribution.website.*.caller_reference, [""]), 0)
}

output "cloudfront_distribution_status" {
  description = "The current status of the distribution. Deployed if the distribution's information is fully propagated throughout the Amazon CloudFront system."
  value       = element(concat(aws_cloudfront_distribution.website.*.status, [""]), 0)
}

output "cloudfront_distribution_domain_name" {
  description = "The domain name corresponding to the distribution."
  value       = element(concat(aws_cloudfront_distribution.website.*.domain_name, [""]), 0)
}

output "s3_bucket_website_domain" {
  value       = aws_s3_bucket.website.bucket_regional_domain_name
}

output "aws_s3_bucket_id" {
  value       = aws_s3_bucket.website.id
}