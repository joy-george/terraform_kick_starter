variable "aws_region" {
  description = "The AWS region in which this infrastructure is to be deployed"
  type = "string"

  default = "us-east-1"
}

variable "default_tags" {
  description = "Default tags that needs to be applied on all the resources"
  type = "map"

  default = {
    Service = "test_service"
  }
}

// This could also be a map wherein the key can be the environment name and value being the respective vpc-id
variable "compute_vpc_id" {
  description = "The VPC ID in which all compute resources will be deployed"
  type = "string"
}

// This could also be a map wherein the key could either be the vpc id seleced above or the environment
variable "compute_subnets" {
  description = "Subnets over which the ELB will be deployed"
  type = "list"
}

variable "web_elb_name" {
  description = "Name used for the web ELB"
  type = "string"

  default = "web-elb"
}

variable "web_elb_ports" {
  description = "ELB ports on which access will be allowed"
  type = "list"

  default = ["443"]
}

variable "web_instance_name" {
  description = "Name used for the web instance"
  type = "string"

  default = "web-instance"
}

variable "web_instance_ports" {
  description = "Web instance ports on which access will be allowed"
  type = "list"

  default = ["8080"]
}

variable "elb_access_log_config" {
  type = "map"
  description = "Confiurations required to ship ELB access logs to s3"
}

variable "elb_listener_config" {
  type =  "map"
  description = "ELB listener configuration"
}

variable "elb_health_check_config" {
  type = "map"
  description = "ELB health check configuration"

  default = {
    healthy_threshold = "3",
    unhealthy_threshold = "3",
    timeout = "2",
    interval = "10",
    target = "HTTP:8080/health",
  }
}