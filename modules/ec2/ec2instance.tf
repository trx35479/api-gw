# Spinning instance with datasource

resource "aws_instance" "mainInstance" {
  ami                    = "${var.IMAGE_ID}"
  count                  = "${element(var.COUNT, 0) == "true" ? element(var.COUNT, 1) : 0}"
  instance_type          = "${var.FLAVOR}"
  subnet_id              = "${element(var.SUBNET_ID, count.index)}"
  vpc_security_group_ids = ["${var.VPC_SECURITY_GROUP_IDS}"]
  key_name               = "${var.AWS_KEYPAIR}"
  user_data              = "${var.USER_DATA}"

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "${var.VOLUME_SIZE}"
    iops                  = "${var.VOLUME_IOPS}"
    delete_on_termination = true
  }

  tags = "${var.TAGS}"

  volume_tags {
    Name = "${lookup(var.TAGS, "Name")}"
  }
}

# show the private_ips of the instances

output "private_ip" {
  value = "${aws_instance.mainInstance.*.private_ip}"
}

output "instance_ids" {
  value = "${aws_instance.mainInstance.*.id}"
}

output "public_ip" {
  value = "${aws_instance.mainInstance.*.public_ip}"
}
