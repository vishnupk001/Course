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


variable "loadbalancer_ingress_ports" {
description = "ingress port of alb sg"
type = list
}

variable "debug_backend" {
description = "to debug backend"
type = bool
}

variable "bastion_instance_type" {
  description = "bastion ec2 instance type"
  type        = string
}

variable "bastion_ami_id" {
  description = "bastion instance ami id"
  type        = string
}

variable "backend_instance_type" {
  description = "backend ec2 instance type"
  type        = string
}

variable "asg_min_size" {
  description = "asg min size"
  type        = string
}

variable "asg_max_size" {
  description = "asg max size"
  type        = string
}

variable "asg_desired_size" {
  description = "asg desired size"
  type        = string
}