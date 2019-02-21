resource "aws_elb" "web_elb" {
  name = "${var.web_elb_name}"
  tags = "${var.default_resource_tags}"

  internal = false
  subnets = "${var.compute_subnets}"
  security_groups = ["${var.web_elb_security_group_id}"]

  access_logs {
    bucket = "${var.elb_access_log_config["bucket"]}"
    bucket_prefix = "${var.elb_access_log_config["bucket_prefix"]}/${var.web_elb_name}"
    interval = "${var.elb_access_log_config["interval"]}"
  }

  listener {
    lb_port = "${var.elb_listener_config["lb_port"]}"
    lb_protocol = "${var.elb_listener_config["lb_protocol"]}"

    instance_port = "${var.elb_listener_config["instance_port"]}"
    instance_protocol = "${var.elb_listener_config["instance_protocol"]}"
    ssl_certificate_id = "${var.elb_listener_config["ssl_certificate_id"]}"
  }

  health_check {
    healthy_threshold = "${var.elb_health_check_config["healthy_threshold"]}"
    unhealthy_threshold = "${var.elb_health_check_config["unhealthy_threshold"]}"
    timeout = "${var.elb_health_check_config["timeout"]}"
    target = "${var.elb_health_check_config["target"]}"
    interval = "${var.elb_health_check_config["interval"]}"
  }
}