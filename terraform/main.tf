provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "infra_docs" {
  bucket = "${var.project_name}-infra-docs-${var.environment}"

  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

resource "aws_s3_bucket_public_access_block" "infra_docs" {
  bucket = aws_s3_bucket.infra_docs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}