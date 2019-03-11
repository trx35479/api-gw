# Variables form the sub-module

variable "REST_API_ID" {}

variable "RESOURCE_ID" {}

variable "HTTP_METHOD" {}

variable "METHOD_PARAMS" {
  default = ""
}

variable "INTEGRATION_PARAMS" {
  default = ""
}

variable "INTEGRATION_TYPE" {}

variable "INTEGRATION_URI" {}

variable "CONNECTION_TYPE" {
  default = ""
}

variable "CONNECTION_ID" {
  default = ""
}
