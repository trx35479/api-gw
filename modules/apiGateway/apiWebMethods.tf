# Create Api for webMethods and call the method and integration methods

# GET /api
module "webMethods" {
  source = "./apiMethodIntegration"

  REST_API_ID        = "${aws_api_gateway_rest_api.restApi.id}"
  RESOURCE_ID        = "${aws_api_gateway_resource.apiRootResource.id}"
  HTTP_METHOD        = "GET"
  METHOD_PARAMS      = "${element(var.PARAMS, 0)}"
  INTEGRATION_PARAMS = "${element(var.PARAMS, 1)}"
  INTEGRATION_TYPE   = "HTTP"
  INTEGRATION_URI    = "${element(var.INTEGRATION_URI, 0)}/"
  CONNECTION_TYPE    = "VPC_LINK"
  CONNECTION_ID      = "${var.ALB_VPC_LINK}"
}
