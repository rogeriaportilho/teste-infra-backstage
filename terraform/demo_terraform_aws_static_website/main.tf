terraform {
  required_providers {
    aws       = {
      version = "~> 4.0"
    }
  }
}

# Data information from Domain and TLS Certificate

# Route53 domain zone
data "aws_route53_zone" "domain" {
  name        = var.domain_name
}

# Get the ARN of the issued certificate
data "aws_acm_certificate" "tls_domain" {
  domain      = var.domain_name
  statuses    = ["ISSUED"]
}

## S3
# Creates bucket to store the static website
resource "aws_s3_bucket" "website" {
  bucket           = var.bucket_name

  # Comment the following line if you are uncomfortable with Terraform destroying the bucket even if not empty
  force_destroy    = true

  tags = merge(var.tags, {
    Project        = "Demo DX"
    ManagedBy      = "terraform"
    Changed        = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
  })

  lifecycle {
    ignore_changes = [tags["Changed"]]
  }
}

# Creates policy to allow public access to the S3 bucket
resource "aws_s3_bucket_policy" "website" {
  bucket          = aws_s3_bucket.website.id

  policy          = jsonencode({
    Version       = "2012-10-17"
    Id            = "PolicyForWebsiteEndpointsPublicContent",
    Statement     = [
      {
        Sid       = "PublicRead"
        Effect    = "Allow"
        Principal = "*"
        Action    = [
          "s3:GetObject"
        ],
        Resource  = [
          aws_s3_bucket.website.arn,
          "${aws_s3_bucket.website.arn}/*",
          "${aws_s3_bucket.website.arn}"
        ]
      },
    ]
  })
}

resource "aws_s3_bucket_acl" "website" {
  bucket   = aws_s3_bucket.website.id
  acl      = "public-read"
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket   = aws_s3_bucket.website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key    = var.support-spa ? "" : "404.html"
  }
}

## CloudFront
# Creates the CloudFront distribution to serve the static website
resource "aws_cloudfront_distribution" "website" {
  enabled                          = true
  price_class                      = "PriceClass_100" # Select the correct PriceClass depending on who the CDN is supposed to serve (https://docs.aws.amazon.com/AmazonCloudFront/ladev/DeveloperGuide/PriceClass.html)
  aliases                          = ["${var.bucket_name}.${var.domain_name}"]
  comment                          = "Deploy terraform stack project Demo DX"

  origin {
    origin_id                      = "${aws_s3_bucket.website.id}"
    domain_name                    = aws_s3_bucket.website.bucket_regional_domain_name

    custom_origin_config {
      origin_protocol_policy       = "http-only" # The protocol policy that you want CloudFront to use when fetching objects from the origin server (a.k.a S3 in our situation). HTTP Only is the default setting when the origin is an Amazon S3 static website hosting endpoint, because Amazon S3 doesn’t support HTTPS connections for static website hosting endpoints.
      http_port                    = 80
      https_port                   = 443
      origin_ssl_protocols         = ["TLSv1.2", "TLSv1.1", "TLSv1"]
    }
  }

  default_root_object              = "index.html"

  default_cache_behavior {
    allowed_methods                = ["GET", "HEAD", "OPTIONS"]
    cached_methods                 = ["GET", "HEAD", "OPTIONS"]
    target_origin_id               = "${aws_s3_bucket.website.id}"
    min_ttl                        = "0"
    default_ttl                    = "300"
    max_ttl                        = "1200"

    viewer_protocol_policy         = "redirect-to-https" # Redirects any HTTP request to HTTPS
    compress                       = true

    forwarded_values {
      query_string                 = false
      cookies {
        forward                    = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type             = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn            = data.aws_acm_certificate.tls_domain.arn
    ssl_support_method             = "sni-only"
  }

  custom_error_response {
    error_caching_min_ttl          = 300
    error_code                     = 404
    response_page_path             = var.support-spa ? "/index.html" : "/404.html"
    response_code                  = var.support-spa ? 200 : 404
  }

  tags = merge(var.tags, {
    Project                        = "Demo DX"
    ManagedBy                      = "terraform"
    Changed                        = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
  })

  lifecycle {
    ignore_changes = [
      tags["Changed"],
      viewer_certificate,
    ]
  }

}

# Creates the DNS record to point on the main CloudFront distribution ID
resource "aws_route53_record" "cloudfront_dns_record_name" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = "${var.bucket_name}.${var.domain_name}"
  type    = "CNAME"
  ttl     = "5"
  records = [aws_cloudfront_distribution.website.domain_name]
}
