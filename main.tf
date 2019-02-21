// Although it has been instructed not to configure the provider.
// But setting the defaults here which can be overriden by specifying the variable using the -var option.
// Example: $ terraform apply -var aws_region=us-west-2
provider "aws" {
  region = "${var.aws_region}"
}

module "elb_security_group" {
  source = "./iam/compute"

  sg_name = "${var.web_elb_name}-sg"
  sg_description = "Web ELB Security Group"
  compute_vpc_id = "${var.compute_vpc_id}"
  default_tags = "${var.default_tags}"

  web_tcp_ports = "${var.web_elb_ports}"
  source_type = "cidr"
  access_ips = ["0.0.0.0/0"]
  egress_all = true
}

module "instance_security_group" {
  source = "./iam/compute"

  sg_name = "${var.web_instance_name}-sg"
  sg_description = "Web Instance Security Group"
  compute_vpc_id = "${var.compute_vpc_id}"
  default_tags = "${var.default_tags}"

  web_tcp_ports = "${var.web_instance_ports}"
  source_type = "sg"
  source_security_group_id = "${module.elb_security_group.td_security_group_id}"
  egress_all = true
}

module "compute_elb" {
  source = "./compute/load_balancer"

  web_elb_name = "${var.web_elb_name}"
  compute_vpc_id = "${var.compute_vpc_id}"
  compute_subnets = "${var.compute_subnets}"
  default_resource_tags = "${var.default_tags}"


  web_elb_security_group_id = "${module.elb_security_group.td_security_group_id}"
  elb_health_check_config = "${var.elb_health_check_config}"
  elb_access_log_config = "${var.elb_access_log_config}"
  elb_listener_config = "${var.elb_listener_config}"
}