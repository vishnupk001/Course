variable "aws_region" {
  description = "aws region name"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "project name"
  type        = string
  default     = "zomato"
}

variable "project_environment" {
  description = "project environment"
  type        = string
  default     = "production"
}


variable "instance_type" {
  description = "ec2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "instance_ami_id" {
  description = "ec2 instance ami id"
  type        = string
  default     = "ami-00d2dbb426772b03a"
}

variable "hosted_zone_id" {
  description = "route53 hosted zone id"
  type        = string
  default     = "Z04675339HJRK6LI42OL"
}

variable "domain_name" {
  description = "my domain name"
  type        = string
  default     = "vpkdevops.online"
}
variable "hostname" {
  description = "my host name"
  type        = string
  default     = "terraform"
}