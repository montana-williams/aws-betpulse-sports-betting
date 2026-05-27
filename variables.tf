variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name used for resource naming and tagging"
  type        = string
  default     = "betpulse"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "prod"
}
variable "certificate_arn" {
  description = "ARN of the ACM SSL certificate"
  type        = string
  default     = ""
}

variable "database_password" {
  description = "Master password for Aurora database"
  type        = string
  sensitive   = true
  default     = "TempPassword123!"
}

variable "sportradar_api_key" {
  description = "Sportradar API key for odds feed"
  type        = string
  sensitive   = true
  default     = "placeholder-key"
}

variable "aws_account_id" {
  description = "AWS account ID"
  type        = string
}