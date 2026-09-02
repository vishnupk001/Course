module "myvpc"  {

  source = "/home/ec2-user/terraform/modules/vpc/"

  project_name  = var.project_name
  project_environment = var.project_environment
  vpc_cidr_block = var.vpc_cidr_block
  enable_natgw = var.enable_natgw
}



resource "aws_security_group" "webserver" {
  name        = "${var.project_name}-${var.project_environment}-webserver"
  description = "${var.project_name}-${var.project_environment}-webserver"
  vpc_id = module.myvpc.vpc_id
  
  egress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  
  egress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.project_environment}-webserver"
  }
}

resource "aws_instance" "webserver" {

  ami                    = "ami-00d2dbb426772b03a"
  instance_type          = "t3.micro"
  key_name               = "vpk_devops"
  vpc_security_group_ids = [ aws_security_group.webserver.id ]
  subnet_id = module.myvpc.subnet_public1_id
  tags = {
    Name        = "${var.project_name}-${var.project_environment}-webserver"
  }

  lifecycle {
    create_before_destroy = true
  }
}