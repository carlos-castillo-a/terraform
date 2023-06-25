# Bucket(s)
resource "aws_s3_bucket" "aws001-bucket" {
  bucket = "aws${var.project}-${var.environment}-bucket"
}

resource "aws_s3_bucket_public_access_block" "aws001-public-access" {
  bucket = aws_s3_bucket.aws001-bucket.id

  block_public_acls       = var.s3_block_public_acls
  block_public_policy     = var.s3_block_public_policy
  ignore_public_acls      = var.s3_ignore_public_acls
  restrict_public_buckets = var.s3_restrict_public_buckets
}