# S3 Bucket
resource "aws_s3_bucket" "tfstate_static_website" {
  bucket        = "tfstate-static-website-backstage-test"
  force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
}

# S3 Bucket Object
resource "aws_s3_object" "terraform" {
  bucket = aws_s3_bucket.tfstate_static_website.id
  key    = "terraform/static-website/"
  source = "/dev/null"
}