output "kinesis_stream_name" {
  description = "Name of the Kinesis odds stream"
  value       = aws_kinesis_stream.odds.name
}

output "odds_poller_function_name" {
  description = "Name of the odds poller Lambda function"
  value       = aws_lambda_function.odds_poller.function_name
}