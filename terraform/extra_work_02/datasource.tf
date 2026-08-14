data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_acm_certificate" "amazon_issued" {
  domain      = "${var.hostname}.${var.domain_name}"
  statuses   = ["ISSUED"]
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}

data "aws_ami" "ami" {
  most_recent      = true

  filter {
    name   = "name"
    values = ["alb-image"]
  }
}

data "aws_route53_zone" "domain" {

name = var.domain_name
private_zone = false

}