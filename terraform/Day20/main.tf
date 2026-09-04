resource "aws_security_group" "frontend" {
  name        = "${var.project_name}-${var.project_environment}-frontend"
  description = "${var.project_name}-${var.project_environment}-frontend"
  
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  
  ingress {
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
    Name = "${var.project_name}-${var.project_environment}-frontend"
  }
}

resource "aws_instance" "frontend" {

  ami                    = data.aws_ami.application.image_id
  instance_type          = var.instance_type
  key_name               = "vpk_devops"
  vpc_security_group_ids = [ aws_security_group.frontend.id]
  
  tags = {
    Name = "${var.project_name}-${var.project_environment}-frontend"
  }

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_eip" "frontend" {
  instance = aws_instance.frontend.id
  domain   = "vpc"
  tags = {
    Name        = "${var.project_name}-${var.project_environment}-frontend"
  } 
}

resource "aws_route53_record" "www" {
  zone_id = var.hosted_zone_id
  name    = "${var.hostname}.${var.domain_name}"
  type    = "A"
  ttl     = 0
  records = [aws_eip.frontend.public_ip]
}