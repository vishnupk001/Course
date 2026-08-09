variable "aws_region" {
  description = "aws region name"
  type        = string
  default     = "ap-south-1"
}

variable "aws_access_key" {
  description = "aws access key"
  type        = string
  default     = "AKIAYFYJGMJ4CEB3C3H4"
}

variable "aws_secret_key" {
  description = "aws secret key"
  type        = string
  default     = "lOd141OTC+AXTQyLKZab9rtoYcZluFp9ZVxao3zp"
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


provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_instance" "webserver" {

  ami                    = var.instance_ami_id
  instance_type          = var.instance_type
  key_name               = "vpk_devops"
  vpc_security_group_ids = ["sg-03c7e232616d0c054", "sg-0eda3ba39e9ab965b"]
  tags = {
    Name        = "${var.project_name}-${var.project_environment}-webserver"
    Project     = var.project_name
    Environemnt = var.project_environment
  }
}