variable "sg_name" {
  description = "Name of the security group"
  type = "string"
}

variable "sg_description" {
  description = "Description for the security group"
  type = "string"
}

variable "default_tags" {
  description = "Default tag that should be applied on all resources"
  type = "map"
}

// This could also be a map wherein the key can be the environment name and value being the respective vpc-id
variable "compute_vpc_id" {
  description = "The VPC ID in which all compute resources will be deployed"
  type = "string"
}

variable "source_type" {
  description = "Source type defines if the incoming traffic is to be allowed from IPs or Security Group"
  type = "string"
}

variable "source_security_group_id" {
  description = "Source security group id (if any)"
  default = "null"
}

variable "web_tcp_ports" {
  description = "List of all web ports which needs to be allowed in the security group rule"
  type  = "list"
}

variable "access_ips" {
  description = "List of all CIDR blocks which needs to be allowed in the security group rule"
  type  = "list"

  default = []
}

variable "egress_all" {
  description = "Security rule to allow all outbound traffic"
  type  = "string"

  default = false
}