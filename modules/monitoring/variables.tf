variable "project_name" {
  description = "Project name used for resource naming and tagging"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "aws_account_id" {
  description = "AWS account ID for unique s3 bucket naming"
  type        = string
}

variable "alert_email" {
  description = "Email address for SNS alerts"
  type        = string
  default     = "alerts@betpulse.com"
}