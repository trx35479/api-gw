# Basic http method and integration
resource "aws_api_gateway_method" "apiMethod" {
  rest_api_id   = "${var.REST_API_ID}"
  resource_id   = "${var.RESOURCE_ID}"
  http_method   = "${var.HTTP_METHOD}"
  authorization = "NONE"

  request_parameters = {
    "method.request.path.id" = true
  }
}

resource "aws_api_gateway_integration" "apiIntegration" {
  rest_api_id             = "${var.REST_API_ID}"
  resource_id             = "${var.RESOURCE_ID}"
  http_method             = "${aws_api_gateway_method.apiMethod.http_method}"
  integration_http_method = "${var.HTTP_METHOD}"
  type                    = "${var.INTEGRATION_TYPE}"
  uri                     = "http://${var.INTEGRATION_URI}"

  request_parameters = {
    "integration.request.path.id" = "method.request.path.id"
  }

  connection_type = "${var.CONNECTION_TYPE}"
  connection_id   = "${var.CONNECTION_ID}"

  depends_on = ["aws_api_gateway_method.apiMethod"]
}

# Integration response

resource "aws_api_gateway_method_response" "apiMethodResponse" {
  rest_api_id = "${var.REST_API_ID}"
  resource_id = "${var.RESOURCE_ID}"
  http_method = "${aws_api_gateway_method.apiMethod.http_method}"
  status_code = "200"

  response_parameters = {
    "method.response.header.X-Amzn-Trace-Id" = true
  }

  depends_on = ["aws_api_gateway_integration.apiIntegration"]
}

resource "aws_api_gateway_integration_response" "apiIntegrationResponse" {
  rest_api_id       = "${var.REST_API_ID}"
  resource_id       = "${var.RESOURCE_ID}"
  http_method       = "${aws_api_gateway_method.apiMethod.http_method}"
  status_code       = "${aws_api_gateway_method_response.apiMethodResponse.status_code}"
  selection_pattern = "200"                                                              # review later this response pattern (use regex)

  depends_on = ["aws_api_gateway_method_response.apiMethodResponse"]
}
