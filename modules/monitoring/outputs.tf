output "audit_bucket_name" {
    description = "Name of the S3 audit log bucket"
    value       = aws_s3_bucket.audit_logs.id
}

output "sns_topic_arn" {
    description = "ARN of the SNS alerts topic"
    value       = aws_sns_topic.alerts.arn
}