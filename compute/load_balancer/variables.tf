variable "web_elb_name" {
  description = "Name used for the web ELB"
  type = "string"
}

variable "default_resource_tags" {
  description = "Default tag that should be applied on all resources"
  type = "map"
}

variable "compute_vpc_id" {
  description = "The VPC ID in which all resources will be deployed"
  type = "string"
}

variable "compute_subnets" {
  description = "Subnets in which the ELB will be deployed"
  type = "list"
}

variable "web_elb_security_group_id" {
  description = "Security group ID that needs to be attached to the ELB"
  type = "string"
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
}