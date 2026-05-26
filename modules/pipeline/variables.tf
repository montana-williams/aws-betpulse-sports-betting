variable "project_name" {
  description = "Project name used for resource naming and tagging"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "sportradar_api_key" {
  description = "Sportradar API key"
  type        = string
  sensitive   = true
  default     = "placeholder-key"
}