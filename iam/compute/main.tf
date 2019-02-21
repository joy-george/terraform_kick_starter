resource "aws_security_group" "td_security_group" {
  name        = "${var.sg_name}"
  description = "${var.sg_description}"

  tags = "${var.default_tags}"
  vpc_id = "${var.compute_vpc_id}"
}

resource "aws_security_group_rule" "ingress_cidr_tcp" {
  count = "${var.source_type == "cidr" ? length(var.web_tcp_ports) : 0}"
  type = "ingress"

  from_port = "${element(var.web_tcp_ports, count.index)}"
  to_port = "${element(var.web_tcp_ports, count.index)}"

  protocol = "tcp"
  cidr_blocks = "${var.access_ips}"
  security_group_id = "${aws_security_group.td_security_group.id}"
}

resource "aws_security_group_rule" "ingress_source_sg_tcp" {
  count = "${var.source_type == "sg" ? length(var.web_tcp_ports) : 0}"
  type = "ingress"

  from_port = "${element(var.web_tcp_ports, count.index)}"
  to_port = "${element(var.web_tcp_ports, count.index)}"

  protocol = "tcp"
  source_security_group_id  = "${var.source_security_group_id}"
  security_group_id = "${aws_security_group.td_security_group.id}"
}

resource "aws_security_group_rule" "egress_all" {
  count = "${var.egress_all ? 1 : 0}"
  type = "egress"

  from_port = 0
  to_port = 65535

  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.td_security_group.id}"
}