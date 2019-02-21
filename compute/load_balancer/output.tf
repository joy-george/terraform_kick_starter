output "web_elb_id" {
  value = "${aws_elb.web_elb.id}"
}

output "web_elb_zone_id" {
  value = "${aws_elb.web_elb.zone_id}"
}