output "infra_docs_bucket_name" {
  value       = aws_s3_bucket.infra_docs.bucket
  description = "The name of the s3 bucket for infrastructure documentation"

}

output "infra_docs_bucket_arn" {
  value       = aws_s3_bucket.infra_docs.arn
  description = "The ARN of the s3 bucket for infrastructure documentation"

}