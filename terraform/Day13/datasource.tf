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

