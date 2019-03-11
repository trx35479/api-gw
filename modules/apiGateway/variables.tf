# apiGateway root module level variables

variable "API_PATH_PART" {}

variable "PARAMS" {
  type    = "list"
  default = ["method.request.path.id", "integration.request.path.id"]
}

variable "INTEGRATION_URI" {
  type = "list"
}

variable "ALB_VPC_LINK" {}
