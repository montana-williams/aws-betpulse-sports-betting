variable "project_name" {
  description = "Project name used for resource naming and tagging"
  type        = string
}

variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "database_subnet_1_id" {
  description = "ID of database subnet 1"
  type        = string
}

variable "database_subnet_2_id" {
  description = "ID of database subnet 2"
  type        = string
}

variable "aurora_security_group_id" {
  description = "ID of the Aurora security group"
  type        = string
}

variable "database_name" {
  description = "Name of the database"
  type        = string
  default     = "betpulse"
}

variable "database_username" {
  description = "Master username for Aurora"
  type        = string
  default     = "betpulse_admin"
}

variable "database_password" {
  description = "Master password for Aurora"
  type        = string
  sensitive   = true
}

variable "instance_class" {
  description = "Aurora instance class"
  type        = string
  default     = "db.t3.medium"
}
