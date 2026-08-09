# ============================================================
# 1. AWS KEY PAIR
# ============================================================
# Creates an AWS EC2 Key Pair for SSH access to the web servers.

resource "aws_key_pair" "authentication_key" {
  key_name   = "${var.project_name}-${var.project_environment}"
  public_key = file("my_alb.pub")

  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}


# ============================================================
# 2. ALB SECURITY GROUP
# ============================================================
# Security group for the Application Load Balancer.

resource "aws_security_group" "alb-access" {
  name        = "${var.project_name}-${var.project_environment}-alb"
  description = "${var.project_name}-${var.project_environment}-alb"
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.project_environment}-alb"
  }
}

# ============================================================
# 3. EC2 / WEB SERVER SECURITY GROUP
# ============================================================
# Security group for the EC2 web servers.

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


# ============================================================
# 4. ALB HTTP INBOUND RULE
# ============================================================
# Allows HTTP traffic from the Internet to the ALB.

resource "aws_security_group_rule" "alb-http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]

  security_group_id = aws_security_group.alb-access.id
}


# ============================================================
# 5. ALB HTTPS INBOUND RULE
# ============================================================
# Allows HTTPS traffic from the Internet to the ALB.

resource "aws_security_group_rule" "alb-https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]

  security_group_id = aws_security_group.alb-access.id
}


# ============================================================
# 6. EC2 HTTP ACCESS FROM ALB
# ============================================================
# Allows the ALB to send HTTP traffic to the EC2 servers.

resource "aws_security_group_rule" "web-http" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"

  source_security_group_id = aws_security_group.alb-access.id
  security_group_id        = aws_security_group.ssh-access.id
}


# ============================================================
# 7. EC2 HTTPS ACCESS FROM ALB
# ============================================================
# Allows the ALB to send HTTPS traffic to the EC2 servers.

resource "aws_security_group_rule" "web-https" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"

  source_security_group_id = aws_security_group.alb-access.id
  security_group_id        = aws_security_group.ssh-access.id
}


# ============================================================
# 8. APPLICATION LOAD BALANCER
# ============================================================
# Creates an Internet-facing Application Load Balancer across three subnets.

resource "aws_lb" "alb" {
  name               = "${var.project_name}-${var.project_environment}-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.alb-access.id
  ]

  subnets = [
    "subnet-0c7c750a988c30673",
    "subnet-081f4ffba2ae92e22",
    "subnet-0e26ae178c8722050"
  ]

  enable_deletion_protection = false

  tags = {
    Name = "${var.project_name}-${var.project_environment}-alb"
  }
}

# ============================================================
# 9. HTTPS LISTENER
# ============================================================
# HTTPS listener that forwards secure traffic from the ALB to the target group.

resource "aws_lb_listener" "alb-https" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn = var.ssl_certificate_id
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb.arn
  }
}


# ============================================================
# 10. HTTP LISTENER
# ============================================================
# HTTP listener that redirects HTTP traffic to HTTPS.

resource "aws_lb_listener" "alb-http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}


# ============================================================
# 12. ALB TARGET GROUP
# ============================================================
# Target group that receives ALB traffic and forwards it to the EC2 servers.

resource "aws_lb_target_group" "alb" {
  name     = "${var.project_name}-${var.project_environment}-alb-tg"
  port     = 80
  protocol = "HTTP"

  vpc_id = var.aws_vpc_id
}


# ============================================================
# 13. TARGET GROUP ATTACHMENT
# ============================================================
# Registers the EC2 web servers with the ALB target group.

resource "aws_lb_target_group_attachment" "alb" {
  count            = 3
  target_group_arn = aws_lb_target_group.alb.arn
  target_id        = aws_instance.webserver[count.index].id
  port             = 80
}


# ============================================================
# 14. EC2 WEB SERVERS
# ============================================================
# Creates three EC2 web servers with the same configuration.

resource "aws_instance" "webserver" {

  count = 3

  ami           = var.instance_ami_id
  instance_type = var.instance_type

  key_name = aws_key_pair.authentication_key.id

  vpc_security_group_ids = [
    aws_security_group.ssh-access.id
  ]

  user_data = file("setup.sh")

  tags = {
    Name = "${var.project_name}-${var.project_environment}-webserver-${count.index + 1}"
  }
}

# ============================================================
# 15. Route53 DNS record
# ============================================================
# Creates a Route53 DNS record that points the domain to the ALB.

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = "${var.hostname}.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}