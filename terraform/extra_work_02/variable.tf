variable "aws_region" {
  description = "aws region name"
  type        = string
}

variable "project_name" {
  description = "project name"
  type        = string
}

variable "project_environment" {
  description = "project environment"
  type        = string
}

variable "vpc_cidr_block" {
  description = "vpc network block"
  type        = string
}

variable "enable_natgw" {
  description = "enable nat gateway"
  type        = bool
}

variable "instance_type" {
  description = "ec2 instance type"
  type        = string
}

variable "domain_name" {
  description = "my domain name"
  type        = string
}

variable "hostname" {
  description = "my host name"
  type        = string
}