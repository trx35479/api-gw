# Collection of datasources

data "aws_availability_zones" "az" {}

data "aws_ami" "centosAmi" {
  most_recent = "true"
  owners      = ["679593333241"]

  filter {
    name   = "name"
    values = ["CentOS Linux 7 x86_64 HVM EBS*"]
  }
}

data "aws_ami" "windowsServerFull" {
  most_recent = "true"
  owners      = ["801119661308"]

  filter {
    name   = "name"
    values = ["Windows_Server-2016-English-Full-Base-*"]
  }
}

data "template_file" "user_data" {
  template = "${file("templates/install_nginx.tpl")}"
}

data "aws_vpc" "unicoIotVpc" {
  filter {
    name   = "owner-id"
    values = ["733282253768"]
  }

  tags {
    Name    = "Unico-IOT-POC"
    Owner   = "UnicoDevOps"
    Project = "unico-iot-poc"
  }
}

data "aws_subnet_ids" "unicoIotSubnets" {
  vpc_id = "${data.aws_vpc.unicoIotVpc.id}"

  tags {
    Name = "Unico-IOT-POC-Private-*"
  }
}

data "aws_security_groups" "unicoIOTSecurityGroups" {
  filter {
    name   = "vpc-id"
    values = ["${data.aws_vpc.unicoIotVpc.id}"]
  }

  tags {
    Name  = "Unico-IOT-POC-*"
    Owner = "UnicoDevOps"
  }
}
