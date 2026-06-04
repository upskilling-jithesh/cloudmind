variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project name used in resource naming"
  type        = string
  default     = "cloudmind"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}