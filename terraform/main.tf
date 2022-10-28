resource "aws_apigatewayv2_api" "flightpicker_api" {
  name          = "flightpicker-api"
  protocol_type = "HTTP"
  cors_configuration {
    allow_origins = ["https://*"]
  }
}