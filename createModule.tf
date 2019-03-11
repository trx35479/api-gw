# Instantiate the modules
provider "aws" {
  region = "${var.AWS_REGION}"
}

resource "aws_key_pair" "mykeypair" {
  key_name   = "${var.CLUSTER_NAME}-mykeypair"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

module "webMethods" {
  source = "modules/ec2"

  AWS_KEYPAIR            = "${aws_key_pair.mykeypair.key_name}"
  IMAGE_ID               = "${data.aws_ami.windowsServerFull.id}"
  FLAVOR                 = "t2.small"
  SUBNET_ID              = ["${element(data.aws_subnet_ids.unicoIotSubnets.ids, 0)}"]
  VPC_SECURITY_GROUP_IDS = "${data.aws_security_groups.unicoIOTSecurityGroups.ids}"
  COUNT                  = ["true", 1]
  TAGS                   = "${map("CostCode", "00000", "Name", "webMethods", "Owner", "Raj Shetjar", "Project", "iot-poc-asg", "Schedule", "10x5", "auto_snapshot", true)}"
  VOLUME_SIZE            = 50
  VOLUME_IOPS            = 150

  #  USER_DATA              = "${data.template_file.user_data.rendered}"
}

module "dashBoard" {
  source = "modules/ec2"

  AWS_KEYPAIR            = "${aws_key_pair.mykeypair.key_name}"
  IMAGE_ID               = "${data.aws_ami.windowsServerFull.id}"
  FLAVOR                 = "t2.small"
  SUBNET_ID              = ["${element(data.aws_subnet_ids.unicoIotSubnets.ids, 1)}"]
  VPC_SECURITY_GROUP_IDS = "${data.aws_security_groups.unicoIOTSecurityGroups.ids}"
  COUNT                  = ["true", 1]
  TAGS                   = "${map("CostCode", "00000", "Name", "Dashboard", "Owner", "Raj Shetjar", "Project", "iot-poc-asg", "Schedule", "10x5", "auto_snapshot", true)}"
  VOLUME_SIZE            = 50
  VOLUME_IOPS            = 150

  #  USER_DATA              = "${data.template_file.user_data.rendered}"
}

module "serverDeviceAgents" {
  source = "modules/ec2"

  AWS_KEYPAIR            = "${aws_key_pair.mykeypair.key_name}"
  IMAGE_ID               = "${data.aws_ami.centosAmi.id}"
  FLAVOR                 = "t2.small"
  SUBNET_ID              = ["${element(data.aws_subnet_ids.unicoIotSubnets.ids, 2)}"]
  VPC_SECURITY_GROUP_IDS = "${data.aws_security_groups.unicoIOTSecurityGroups.ids}"
  COUNT                  = ["true", 1]
  TAGS                   = "${map("CostCode", "00000", "Name", "SeverDeviceAgents", "Owner", "Raj Shetjar", "Project", "iot-poc-asg", "Schedule", "10x5", "auto_snapshot", true)}"
  VOLUME_SIZE            = 50
  VOLUME_IOPS            = 150

  #  USER_DATA              = "${data.template_file.user_data.rendered}"
}

module "apiGateway" {
  source = "modules/apiGateway"

  API_PATH_PART   = "api"
  ALB_VPC_LINK    = "${aws_api_gateway_vpc_link.apiGwLoadBalancer.id}"
  INTEGRATION_URI = ["${aws_lb.networkLoadBalancer.dns_name}"]
}


output "api_url" {
  value = "${module.apiGateway.base_url}"
}

