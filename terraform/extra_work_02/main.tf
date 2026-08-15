# ============================================================
# 1. VPC Creation
# ============================================================

resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}

# ============================================================
# 2. Internet Gateway
# ============================================================

resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}
# ============================================================
# 3. Public Subnets
# ============================================================


resource "aws_subnet" "public_subnet" {

  count      =  3

  vpc_id     = aws_vpc.main.id

  cidr_block = cidrsubnet(var.vpc_cidr_block, 4, count.index)

  map_public_ip_on_launch = true
  availability_zone_id = data.aws_availability_zones.available.zone_ids[count.index]

  tags = {
    Name = "${var.project_name}-${var.project_environment}-public_${count.index + 1}"
    Type = "public"
  }
}

# ============================================================
# 3. Private Subnets
# ============================================================

resource "aws_subnet" "private_subnet" {
  
  count      =  3

  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.vpc_cidr_block, 4, count.index + 3)
  map_public_ip_on_launch = false
  availability_zone_id = data.aws_availability_zones.available.zone_ids[count.index]

  tags = {
    Name = "${var.project_name}-${var.project_environment}-private_${count.index + 1}"
    Type = "private"
  }
}

# ============================================================
# 4. Public Route Table
# ============================================================

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project_name}-${var.project_environment}-public"
    Type = "public"
  }
}

# ============================================================
# 5. Public Route Table Associations
# ============================================================

resource "aws_route_table_association" "public" {
  
  count          =   3

  subnet_id = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public.id
}

# ============================================================
# 6. EIP for nat
# ============================================================

resource "aws_eip" "nat" {

  count = var.enable_natgw ? 1 : 0

  domain   = "vpc"
  tags = {
    Name = "${var.project_name}-${var.project_environment}-nat"
  }
}

# ============================================================
# 7. Nat Gateway
# ============================================================

resource "aws_nat_gateway" "nat" {
 
  count = var.enable_natgw ? 1 : 0

  allocation_id = aws_eip.nat[0].id
  subnet_id     = aws_subnet.public_subnet[1].id

  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }

  depends_on = [aws_internet_gateway.igw]
}

# ============================================================
# 8. Private Route Table
# ============================================================

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-${var.project_environment}-private"
    Type = "private"
  }
}

# ============================================================
# 9. Route the Nat Gateway
# ============================================================

resource "aws_route" "nat_gw_route" {

  count = var.enable_natgw ? 1 : 0

  route_table_id              = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id       = aws_nat_gateway.nat[0].id
}


# ============================================================
# 10. Private Route Table Associations
# ============================================================

resource "aws_route_table_association" "private" {

  count          =   3

  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private.id
}

# ============================================================
# 11. AWS KEY PAIR
# ============================================================

resource "aws_key_pair" "authentication_key" {
  key_name   = "${var.project_name}-${var.project_environment}"
  public_key = file("myown.pub")

  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}

# ============================================================
# 12. ALB SECURITY GROUP
# ============================================================

resource "aws_security_group" "alb-access" {
  name        = "${var.project_name}-${var.project_environment}-alb"
  description = "${var.project_name}-${var.project_environment}-alb"
  vpc_id      = aws_vpc.main.id
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
# 13. EC2 / WEB SERVER SECURITY GROUP
# ============================================================

resource "aws_security_group" "ssh-access" {
  name        = "${var.project_name}-${var.project_environment}-ssh"
  description = "${var.project_name}-${var.project_environment}-ssh"
  vpc_id      = aws_vpc.main.id
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
# 14. ALB HTTP INBOUND RULE
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
# 15. ALB HTTPS INBOUND RULE
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
# 16. EC2 HTTP ACCESS FROM ALB
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
# 17. EC2 HTTPS ACCESS FROM ALB
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
# 18. Launch Template
# ============================================================

resource "aws_launch_template" "lt" {
  name_prefix   =  "version1"
  image_id      = data.aws_ami.ami.id
  instance_type = var.instance_type
  key_name = aws_key_pair.authentication_key.id
  vpc_security_group_ids = [
    aws_security_group.ssh-access.id
  ]

  tags = {
    Name = "${var.project_name}-${var.project_environment}-webserver"
  }

}

# ============================================================
# 19. ALB TARGET GROUP
# ============================================================

resource "aws_lb_target_group" "tg" {
  name     = "${var.project_name}-${var.project_environment}-alb-tg"
  port     = 80
  protocol = "HTTP"

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-${var.project_environment}-tg"
  }
}


# ============================================================
# 20. APPLICATION LOAD BALANCER
# ============================================================

resource "aws_lb" "alb" {
  
  
  name               = "${var.project_name}-${var.project_environment}-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.alb-access.id
  ]

  subnets            = [for subnet in aws_subnet.public_subnet : subnet.id]

  

  enable_deletion_protection = false

  tags = {
    Name = "${var.project_name}-${var.project_environment}-alb"
  }
}

# ============================================================
# 21. Auto Scaling Group
# ============================================================


resource "aws_autoscaling_group" "asg" {

  
  vpc_zone_identifier = aws_subnet.private_subnet[*].id
  desired_capacity   = 3
  max_size           = 3
  min_size           = 1

  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "${var.project_name}-${var.project_environment}-webserver"
    propagate_at_launch = true

  }

}

# ============================================================
#  22. Auto Scaling Group attached to Target Group
# ============================================================


resource "aws_autoscaling_attachment" "asg_tg" {
  autoscaling_group_name = aws_autoscaling_group.asg.id
  lb_target_group_arn    = aws_lb_target_group.tg.arn
}

# ============================================================
# 23. HTTPS LISTENER
# ============================================================


resource "aws_lb_listener" "alb-https" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn = data.aws_acm_certificate.amazon_issued.id
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}


# ============================================================
# 24. HTTP LISTENER
# ============================================================


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
# 25. Route53 DNS record
# ============================================================

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