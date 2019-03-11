variable "IMAGE_ID" {}

variable "FLAVOR" {}

variable "COUNT" {
  type = "list"
}

variable "VPC_SECURITY_GROUP_IDS" {
  type = "list"
}

variable "AWS_KEYPAIR" {}

variable "SUBNET_ID" {
  type = "list"
}

variable "TAGS" {
  type = "map"
}

variable "USER_DATA" {
  default = ""
}

variable "VOLUME_SIZE" {
  default = ""
}

variable "VOLUME_IOPS" {
  default = ""
}
