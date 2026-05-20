output "alb_security_group_id" {
    description = "ID of the ALB security group"
    value       = aws_security_group.alb.id
}

output "fargate_security_group_id" {
    description = "ID of the Fargate security group"
    value       = aws_security_group.fargate.id
}

output "aurora_security_group_id" {
    description = "ID of the Aurora security group"
    value       = aws_security_group.aurora.id
}

output "redis_security_group_id" {
    description = "ID of the Redis security group"
    value       = aws_security_group.redis.id
}