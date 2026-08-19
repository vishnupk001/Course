data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_ami" "application" {

most_recent = true
name_regex = "${var.project_name}-${var.project_environment}-version*"
owners = [ "self" ]

  filter {
    name = "tag:Project"
    values = [var.project_name ]
  }

  filter {
    name = "tag:Environment"
    values = [ var.project_environment ]
  }

}

data "aws_acm_certificate" "amazon_issued" {
  domain      = "${var.domain_name}"
  statuses   = ["ISSUED"]
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}

data "aws_route53_zone" "domain" {

name = var.domain_name
private_zone = false

}