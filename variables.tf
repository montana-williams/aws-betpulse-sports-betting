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
