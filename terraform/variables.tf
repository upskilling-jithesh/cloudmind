variable "aws_region" {
  default     = "ap-south-1"
  description = "AWS region"
  type        = string
}

variable "project_name" {
  default     = "cloudmind"
  description = "Project Name"
  type        = string

}

variable "environment" {
  default     = "dev"
  description = "Environment Name"
  type        = string

}