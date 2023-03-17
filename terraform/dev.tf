# TODO: All of the code in this file will need to be moved to a module that can be reused for other environments and 
# projects. Any time we want to deploy a new environment, we should be able to do so by using the code below.
# The call will look something like this for reference:
# module "static_website" {
#   source = "git::github.com/jaylong255/terraform-modules.git?ref=v2.0.0"
#   stack = "assets"
#   env = "dev"
# }


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

# Policy and document
data "aws_iam_policy_document" "assets" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [var.principal]
    }

    actions = ["s3:GetObject"]

    resources = ["arn:aws:s3:::${var.stack}-assets-${var.env}/*"]
  }
}

resource "aws_s3_bucket_policy" "bucket" {
  bucket = "${aws_s3_bucket.assets.bucket}"
  policy = data.aws_iam_policy_document.assets.json
}

# DNS Record and SSL certificate

# TODO: Add the DNS record and SSL certificate here

# Access identity, policy and document for the development CDN

locals {
  assets_s3_origin_id = "S3-${var.stack}-assets-${var.env}"
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "CloudFront Origin Access Identity for ${var.stack}-assets-${var.env}"
}

data "aws_iam_policy_document" "cdn" {
  statement {
    actions = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.assets.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "cdn" {
  bucket = aws_s3_bucket.assets.id
  policy = data.aws_iam_policy_document.cdn.json
}

resource "aws_cloudfront_distribution" "distribution" {
  origin {
    domain_name = aws_s3_bucket.assets.bucket_regional_domain_name
    origin_id   = local.assets_s3_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Some comment"
  default_root_object = "index.html"

  aliases = var.aliases

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.assets_s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = "/content/immutable/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = local.assets_s3_origin_id

    forwarded_values {
      query_string = false
      headers      = ["Origin"]

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  # Cache behavior with precedence 1
  ordered_cache_behavior {
    path_pattern     = "/content/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.assets_s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        =  ["US", "CA", "GB", "DE","MX"]
    }
  }

  tags = {
    Project     = var.stack
    Environment = var.env
    Terraform   = "true"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
    minimum_protocol_version = "TLSv1.2_2021"
    acm_certificate_arn = var.certificate_arn
    ssl_support_method = "sni-only"
  }
}
