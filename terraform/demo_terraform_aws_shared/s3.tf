# S3 Bucket
resource "aws_s3_bucket" "tfstate_shared" {
  bucket        = "tfstate-shared-backstage-test"
  force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
}

# S3 Bucket Object
resource "aws_s3_object" "terraform" {
  bucket = aws_s3_bucket.tfstate_shared.id
  key    = "terraform/shared/"
  source = "/dev/null"
}
