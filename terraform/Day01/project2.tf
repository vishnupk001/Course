provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIAYFYJGMJ4CEB3C3H4"
  secret_key = "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"
}

resource "aws_instance" "webserver" {

  ami                    = "ami-00d2dbb426772b03a"
  instance_type          = "t3.micro"
  key_name               = "vpk_devops"
  vpc_security_group_ids = ["sg-03c7e232616d0c054", "sg-0eda3ba39e9ab965b"]
  tags = {
    Name        = "food-app"
    Project     = "food"
    Environemnt = "production"
  }
}

[ec2-user@ip-172-31-1-110 aws-project]$ cat project2.tf 
variable "aws_region" {
description = "aws region name"
type = string
default = "ap-south-1"
}

variable "aws_access_key" {
description = "aws access key"
type = string
default = "AKIAYFYJGMJ4CEB3C3H4"
}

variable "aws_secret_key" {
description = "aws secret key"
type = string
default = "lOd141OTC+AXTQyLKZab9rtoYcZluFp9ZVxao3zp"
}


provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key:q!
}

resource "aws_instance" "webserver" {

  ami                    = "ami-00d2dbb426772b03a"
  instance_type          = "t3.micro"
  key_name               = "vpk_devops"
  vpc_security_group_ids = ["sg-03c7e232616d0c054", "sg-0eda3ba39e9ab965b"]
  tags = {
    Name        = "food-app"
    Project     = "food"
    Environemnt = "production"
  }
}