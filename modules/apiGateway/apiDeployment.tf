# API Deployment

resource "aws_api_gateway_deployment" "apiDeployment" {
  depends_on = ["module.webMethods"]

  rest_api_id = "${aws_api_gateway_rest_api.restApi.id}"
  stage_name  = "dev"
}

output "base_url" {
  value = "${aws_api_gateway_deployment.apiDeployment.invoke_url}"
}
