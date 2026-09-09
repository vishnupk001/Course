
resource "aws_security_group" "webserver" {
  name        = "${var.project_name}-${var.project_environment}-webserver"
  description = "${var.project_name}-${var.project_environment}-webserver"

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

resource "aws_security_group_rule" "webserver-http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.webserver.id
}

resource "aws_security_group_rule" "webserver-https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.webserver.id
}

resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.webserver.id
}

resource "aws_instance" "webserver" {

  ami                    = var.instance_ami_id
  instance_type          = var.instance_type
  key_name               = "vpk_devops"
  vpc_security_group_ids = [aws_security_group.webserver.id]
  user_data = file("setup.sh")
  tags = {
    Name        = "${var.project_name}-${var.project_environment}-webserver"
  }
  lifecycle { 
      create_before_destroy = true 
   }
}
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = "${var.hostname}.${var.domain_name}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.webserver.public_ip]
}