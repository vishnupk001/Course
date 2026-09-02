


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


provider "aws" {
  region     = var.aws_region 
  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.project_environment
    }
  }
}  

resource "null_resource" "provision_ecz_on userdata_changel" {
  
  triggers = {
    userdata_change = filemd(" setup. sh")
  }
  provisioner "file" {
    source      = "./setup.sh"
    destination = "/tmp/setup.sh"

    connection { 
      type     = "ssh"
      user     = "ec2-user"
      host     = aws_instance.webserver.public_ip
      port     =  22
      private_key = "vpk_devops"  
    }
  }
  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/setup.sh",
      "sudo /tmp/setup.sh"
    ]
    connection { 
      type     = "ssh"
      user     = "ec2-user"
      host     = aws_instance.webserver.public_ip
      port     =  22
      private_key = "vpk_devops"  
    }
  }
}

resource "aws_instance" "webserver" {
  ami      = "ami-00d2dbb426772b03a"
  instance_type =  "t3.micro"
  key_name = "vpk_devops"
  vpc_security_group_ids = "sg-0fa0cca3f81790e39"
  tags = {
    Name = "${var.project_name}-${var.project_environment}-webserver"
    }

  
  lifecycle {
    create_before_destroy = true
    }

}