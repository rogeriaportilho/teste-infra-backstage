output "bucket_name" {
  value = aws_s3_bucket.tfstate_shared.bucket
}

output "ecr_url_back" {
  value = aws_ecr_repository.backstage-ecr-back.repository_url
}

output "ecr_url_front" {
  value = aws_ecr_repository.backstage-ecr-front.repository_url
}

output "zone" {
  value = [
    aws_route53_zone.zone-tw.name,
    aws_route53_zone.zone-tw.name_servers,
    aws_route53_zone.zone-tw.zone_id
  ]
}
