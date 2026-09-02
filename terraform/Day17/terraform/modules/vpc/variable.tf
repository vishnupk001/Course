ivariable "project_name" {
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

variable "webserver_instance_type" {
  description = "webserver ec2 instance type"
  type        = string
}

variable "webserver_ami_id" {
  description = "webserver instance ami id"
  type        = string
}