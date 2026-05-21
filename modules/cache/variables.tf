variable "project_name" {
  description = "Project name used for resource naming and tagging"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "private_subnet_1_id" {
  description = "ID of private subnet 1"
  type        = string
}

variable "private_subnet_2_id" {
  description = "ID of private subnet 2"
  type        = string
}

variable "redis_security_group_id" {
  description = "ID of the Redis security group"
  type        = string
}

variable "redis_node_type" {
  description = "ElastiCache node type"
  type        = string
  default     = "cache.t3.micro"
}