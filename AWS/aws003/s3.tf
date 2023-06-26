# Bucket(s)
resource "aws_s3_bucket" "aws003-bucket" {
  bucket = var.environment != "prod" ? format("%s-carlos.%s", var.environment, var.site_domain) : format("carlos.%s", var.site_domain)
}

resource "aws_s3_bucket_public_access_block" "aws003-public-access" {
  bucket = aws_s3_bucket.aws003-bucket.id

  block_public_acls       = var.s3_block_public_acls
  block_public_policy     = var.s3_block_public_policy
  ignore_public_acls      = var.s3_ignore_public_acls
  restrict_public_buckets = var.s3_restrict_public_buckets
}

resource "aws_s3_bucket_versioning" "aws003-versioning" {
  bucket = aws_s3_bucket.aws003-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_website_configuration" "aws003-site" {
  bucket = aws_s3_bucket.aws003-bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_acl" "aws003-acl" {
  bucket = aws_s3_bucket.aws003-bucket.id

  acl = "public-read"
}

resource "aws_s3_bucket_policy" "aws003-policy" {
  bucket = aws_s3_bucket.aws003-bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.aws003-bucket.arn,
          "${aws_s3_bucket.aws003-bucket.arn}/*",
        ]
      },
    ]
  })
}