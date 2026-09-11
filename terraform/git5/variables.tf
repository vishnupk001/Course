variable "aws_region" {
  description = "aws region name"
  type        = string
}



variable "project_name" {
  description = "project name"
  type        = string
}


variable "project_environment" {
  description = "project enviornment"
  type        = string
}

variable "instance_type" {
  description = "ec2 instance type"
  type        = string
}


variable "instance_ami_id" {
  description = "ec2 instance ami id"
  type        = string
}