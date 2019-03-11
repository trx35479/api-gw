# configure the base rest api and root resource

resource "aws_api_gateway_rest_api" "restApi" {
  name        = "apiGateway"
  description = "apiGateway with EC2 backend via VPC_LINK"
}

resource "aws_api_gateway_resource" "apiRootResource" {
  rest_api_id = "${aws_api_gateway_rest_api.restApi.id}"
  parent_id   = "${aws_api_gateway_rest_api.restApi.root_resource_id}"
  path_part   = "${var.API_PATH_PART}"
}
