resource "aws_apigatewayv2_api" "flightpicker_api" {
  name          = "flightpicker-api"
  protocol_type = "HTTP"
  cors_configuration {
    allow_origins = ["https://*"]
  }
}

resource "aws_iam_role" "lambda_role" {
  name = "iam_for_lambda"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_lambda_function" "lambda_function" {
  filename         = "lambda_code.zip"
  function_name    = "flightpicker"
  role             = aws_iam_role.lambda_role.arn
  handler          = "lambda_code.lambda_handler"
  source_code_hash = filebase64sha256("lambda_code.zip")
  runtime          = "java11"
}