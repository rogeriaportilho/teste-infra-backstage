## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |

## Modules

This Terraform module creates the following AWS resources:

* **AWS Certificate Manager**: wildcard certificate for your domain.
* **S3**
  * Bucket #1: to store the content (`example.com`).
  * Bucket #1: security bucket acl policy only public-read.
* **CloudFront**
  * Distribution #1: to frontend the website.
  * Distribution #2: to frontend the subdomain that will be redirected http to the https.
* **Route53** record set pointing to the CloudFront distributions.

    ## Usage
    ```HCL
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
    source = "../s3_cloudfront_module/module"
    
    # This is the bucekt name that's releate the React App Name
    bucket_name = var.bucket_name

    # This is the domain as defined in Route53
    domain_name = var.domain_name
    }
    ```

## Resources

| Name | Type |
|------|------|
| [aws__acm_certificate"](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/acm_certificate) | data sources |
| [aws_route53_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data sources |
| [aws_route53_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_acl](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_website_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration) | resource |
| [aws_cloudfront_distribution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS region used for all resources | `string` | `"us-east-1"` | no |
| <a name="input_aws_domain_name"></a> [aws\_domain_name](#input\_aws\_domain_name) | Add the main domain name which registered in Route 53 for the website (e.g., `empcbr.thoughtworks-lab.net`) | string | - | yes |
| <a name="input_aws_bucket_name"></a> [aws\_bucket_name](#input\_aws\_bucket_name) | The bucket name is relate the name of frontend/website page will concatenate the domain (e.g., `website-template.empcbr.thoughtworks-lab.net`) that don't need redirection | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_s3_bucket_id"></a> [bucket\_name](#output\_bucket\_name) | n/a |
| <a name="output_s3_bucket_website_domain"></a> [bucket\_name\_arn\_website_domain](#output\_bucket\_name\_id\_website_domain) | n/a |
| <a name="output_cloudfront_distribution_arn"></a> [cdn\_arn\_cloudfront_id](#output\_cdn\_arn\_cloudfront_id) | n/a |
| <a name="output_cloudfront_distribution_domain_name"></a> [cdn\_default_url\_cloudfront\_domain_name](#output\cdn\_default_url\_cloudfront\_domain_name) | n/a |
<a name="output_cloudfront_distribution_id "></a> [cdn\_id\_cloudfront_id](#output\_cdn\_id\_cloudfront_id) | n/a |
<a name="output_cloudfront_distribution_status"></a> [cdn\_status\_cloudfront](#output\_cdn\_status\_cloudfront) | n/a |



