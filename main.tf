resource "aws_s3_bucket" "s3_bucket"{
    bucket = var.bucket_name
    tags = var.common_tags
}
resource "aws_s3_bucket_website_configuration" "bucket_website_configuration" {
    bucket = aws_s3_bucket.s3_bucket.id

    index_document {
      suffix = "index.html"
    }

    error_document {
      key = "index.html"    # use an error html page 
    }
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# S3 bucket ACL access

resource "aws_s3_bucket_ownership_controls" "bucket_ownership_control" {
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "bucket_access_block" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls   = false
  block_public_policy = false
}

resource "aws_s3_bucket_acl" "bucket_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.bucket_ownership_control,
    aws_s3_bucket_public_access_block.bucket_ownership_control,
  ]

  bucket = aws_s3_bucket.s3_bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "bucket_policy" {
    bucket = aws_s3_bucket.s3_bucket.id
    policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action = [
          "s3:GetObject"
        ]
        Resource = [
          "${aws_s3_bucket.s3_bucket.arn}/*"
        ]
      }
    ]  
    })
}

output "website_url" {
  value = "http://${aws_s3_bucket.s3_bucket.bucket}.s3-website.${var.region}.amazonaws.com"
}
