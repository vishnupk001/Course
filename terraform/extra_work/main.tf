resource "aws_key_pair" "authentication_key" {
  key_name   = "${var.project_name}-${var.project_environment}"
  public_key = file("mykey.pub")
  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}

resource "aws_security_group" "clb-access" {
  name        = "${var.project_name}-${var.project_environment}-clb"
  description = "${var.project_name}-${var.project_environment}-clb"
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "${var.project_name}-${var.project_environment}-clb"
  }
}

resource "aws_security_group" "ssh-access" {
  name        = "${var.project_name}-${var.project_environment}-ssh"
  description = "${var.project_name}-${var.project_environment}-ssh"
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "${var.project_name}-${var.project_environment}-ssh"
  }
}
resource "aws_security_group_rule" "clb-http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.clb-access.id
}

resource "aws_security_group_rule" "clb-https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.clb-access.id
}

resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.ssh-access.id
}
resource "aws_security_group_rule" "web-http" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.clb-access.id
  security_group_id        = aws_security_group.ssh-access.id
}

resource "aws_security_group_rule" "web-https" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.clb-access.id
  security_group_id        = aws_security_group.ssh-access.id
}

resource "aws_lb" "clb" {
  name               = "${var.project_name}-${var.project_environment}-clb"
  availability_zones = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  security_groups = [aws_security_group.clb-access.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  listener {
    instance_port      = 80
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = var.ssl_certificate_id
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 5
  }

  instances                   = [aws_instance.webserver[0].id, aws_instance.webserver[1].id, aws_instance.webserver[2].id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "${var.project_name}-${var.project_environment}-webserver"
  }
}


resource "aws_instance" "webserver" {

  count                  = 3

  ami                    = var.instance_ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.authentication_key.id
  vpc_security_group_ids = [aws_security_group.ssh-access.id]
  user_data              = file("setup.sh")
  tags = {
    Name = "${var.project_name}-${var.project_environment}-webserver-${count.index + 1}"
  }
}

resource "aws_eip" "webserver" {
  count    = 3
  instance = aws_instance.webserver[count.index].id
  domain   = "vpc"

  tags = {
    Name = "${var.project_name}-${var.project_environment}-webserver-${count.index + 1}"
  }
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = "${var.hostname}.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_elb.clb.dns_name
    zone_id                = aws_elb.clb.zone_id
    evaluate_target_health = true
  }
}
