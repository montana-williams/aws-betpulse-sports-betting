variable "project_name" {
    description = "Project name used for resources naming and tagging"
    type        = string
}

variable "environment" {
    description = "Deployment environment"
    type        = string
}

variable "aws_region" {
    description = "AWS region"
    type        = string
}

variable "vpc_id" {
    description = "ID of the VPC"
    type        = string
}

variable "public_subnet_1_id" {
    description = "ID of public subnet 1"
    type        = string
}

variable "public_subnet_2_id" {
    description = "ID of public subnet 2"
    type        = string
}

variable "private_subnet_1_id" {
    description = "ID of private subnet"
    type        = string
}

variable "private_subnet_2_id" {
    description = "Id of private subnet 2"
    type        = string
}

variable "alb_security_group_id" {
    description = "ID of the ALB security group"
    type        = string
}

variable "fargate_security_group_id" {
    description = "ID of the Fargate security group"
    type        = string
}

variable "certificate_arn" {
    description = "ARN of the ACM certificate for HTTPS"
    type        = string
}

variable "container_image" {
    description = "Container image URI from ECR"
    type        = string
    default     = "nginx:latest"
}

variable "task_cpu" {
    description = "CPU units for the Fargate task"
    type        = string
    default     = "1024"
}

variable "task_memory" {
    description = "Memory for the Fargate task in MB"
    type        = string
    default     = "2048"
}

variable "desired_count" {
    description = "Desired number of containers"
    type        = number
    default     = 2
}

variable "min_capacity" {
    description = "Minimum number of containers"
    type        = number
    default     = 2
}

variable "max_capacity" {
    description = "Maximum number of containers"
    type        = number
    default     = 50
}
