resource "aws_kinesis_stream" "odds" {
  name             = "${var.project_name}-odds-stream"
  shard_count      = 1
  retention_period = 24

  tags = {
    Name        = "${var.project_name}-odds-stream"
    Environment = var.environment
  }
}

resource "aws_cloudwatch_event_rule" "odds_poller" {
  name                = "${var.project_name}-odds-poller"
  description         = "Trigger odds poller Lambda every 2 seconds"
  schedule_expression = "rate(1 minute)"

  tags = {
    Name        = "${var.project_name}-odds-poller"
    Environment = var.environment
  }
}

resource "aws_iam_role" "lambda_pipeline" {
  name = "${var.project_name}-lambda-pipeline-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name        = "${var.project_name}-lambda-pipeline-role"
    Environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  role       = aws_iam_role.lambda_pipeline.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "lambda_kinesis" {
  role       = aws_iam_role.lambda_pipeline.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonKinesisFullAccess"
}

resource "aws_lambda_function" "odds_poller" {
  filename      = "${path.module}/lambda/odds_poller.zip"
  function_name = "${var.project_name}-odds-poller"
  role          = aws_iam_role.lambda_pipeline.arn
  handler       = "index.handler"
  runtime       = "nodejs18.x"

  environment {
    variables = {
      KINESIS_STREAM_NAME = aws_kinesis_stream.odds.name
      SPORTRADAR_API_KEY  = var.sportradar_api_key
    }
  }

  tags = {
    Name        = "${var.project_name}-odds-poller"
    Environment = var.environment
  }
}

resource "aws_cloudwatch_event_target" "odds_poller" {
  rule      = aws_cloudwatch_event_rule.odds_poller.name
  target_id = "OddsPollerLambda"
  arn       = aws_lambda_function.odds_poller.arn
}

resource "aws_lambda_permission" "eventbridge" {
  statement_id  = "AllowEventBridgeInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.odds_poller.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.odds_poller.arn
}