#--------------------------------------------
# S3 Outputs
#--------------------------------------------
output "infra_docs_bucket_name" {
  description = "Name of the infra docs S3 bucket"
  value       = aws_s3_bucket.infra_docs.bucket
}

output "infra_docs_bucket_arn" {
  description = "ARN of the infra docs S3 bucket"
  value       = aws_s3_bucket.infra_docs.arn
}

#--------------------------------------------
# VPC Outputs
#--------------------------------------------
output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = module.vpc.vpc_cidr
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of private subnets"
  value       = module.vpc.private_subnet_ids
}