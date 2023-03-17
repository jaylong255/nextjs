resource "aws_s3_bucket" "assets" {
  bucket = "${var.stack}-assets-${var.env}"

  tags = {
    Project     = var.stack
    Environment = var.env
    Terraform   = "true"
  }
}

# ACL for the bucket.
resource "aws_s3_bucket_acl" "assets" {
  bucket = "${aws_s3_bucket.assets.bucket}"
  acl    = "public-read"
}