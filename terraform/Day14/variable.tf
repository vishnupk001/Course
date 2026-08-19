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

variable "health_check_port" {
  description = "health check port"
  type        = string
}

variable "deregistration_delay" {
  description = "deregistration delay"
  type        = string
}


variable "target_type" {
  description = "target_type"
  type        = string
}

variable "health_check_path" {
  description = "health_check_path"
  type        = string
}


variable "health_check_interval" {
  description = "health_check_interval"
  type        = string
}

variable "health_check_timeout" {
  description = "health_check_timeout"
  type        = string
}

variable "health_check_healthy_threshold" {
  description = "health_check_healthy_threshold"
  type        = string
}

variable "health_check_unhealthy_threshold" {
  description = "health_check_unhealthy_threshold"
  type        = string
}

variable "health_check_protocol" {
  description = "health_check_protocol"
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