 resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}

resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}

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

resource "aws_route_table_association" "public" {
  
  count          =   3

  subnet_id = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat" {

  count = var.enable_natgw ? 1 : 0

  domain   = "vpc"
  tags = {
    Name = "${var.project_name}-${var.project_environment}-nat"
  }
}

resource "aws_nat_gateway" "nat" {
 
  count = var.enable_natgw ? 1 : 0

  allocation_id = aws_eip.nat[0].id
  subnet_id     = aws_subnet.public_subnet[1].id

  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-${var.project_environment}-private"
    Type = "private"
  }
}

resource "aws_route" "nat_gw_route" {

  count = var.enable_natgw ? 1 : 0

  route_table_id              = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id       = aws_nat_gateway.nat[0].id
}

resource "aws_route_table_association" "private" {

  count          =   3

  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private.id
}

#Security groupt for Loadbalancer


resource "aws_security_group" "loadbalancer" {
  name        = "${var.project_name}-${var.project_environment}-loadbalancer"
  description = "${var.project_name}-${var.project_environment}-loadbalancer"
  vpc_id = aws_vpc.main.id
  
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.project_environment}-loadbalancer"
  }
}


resource "aws_security_group_rule" "loadbalancer_ingress" {

  for_each           = toset(var.loadbalancer_ingress_ports)

  type              = "ingress"
  from_port         = each.value
  to_port           = each.value
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.loadbalancer.id
}

# Security groupt for Bastion

resource "aws_security_group" "bastion" {
  name        = "${var.project_name}-${var.project_environment}-bastion"
  description = "${var.project_name}-${var.project_environment}-bastion"
  vpc_id = aws_vpc.main.id
  
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
    Name = "${var.project_name}-${var.project_environment}-bastion"
  }
}

# Security groupt for backend

resource "aws_security_group" "backend" {
  name        = "${var.project_name}-${var.project_environment}-backend"
  description = "${var.project_name}-${var.project_environment}-backend"
  vpc_id = aws_vpc.main.id
  
  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups  = [ aws_security_group.loadbalancer.id , aws_security_group.bastion.id ]
  }
  
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    #security_groups = [ aws_security_group.bastion.id ]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.project_environment}-backend"
  }
}


resource "aws_key_pair" "authentication_key" {
  key_name   = "${var.project_name}-${var.project_environment}"
  public_key = file("key.pub")

  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}

resource "aws_instance" "bastion" {

  ami                    = var.bastion_ami_id
  instance_type          = var.bastion_instance_type
  key_name               = aws_key_pair.authentication_key.id
  vpc_security_group_ids = [ aws_security_group.bastion.id ]
  subnet_id = aws_subnet.public_subnet[0].id
  tags = {
    Name        = "${var.project_name}-${var.project_environment}-bastion"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_template" "application" {
  
  name = "${var.project_name}-${var.project_environment}"
  image_id = data.aws_ami.application.image_id
  instance_type = var.backend_instance_type
  key_name = aws_key_pair.authentication_key.id
  vpc_security_group_ids = [aws_security_group.backend.id ]
  update_default_version = true

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.project_name}-${var.project_environment}-backend"
      Project     = var.project_name
      Environment = var.project_environment
    }
  }
} 


resource "aws_autoscaling_group" "application" {

  name                      = "${var.project_name}-${var.project_environment}"
  desired_capacity          = var.asg_capacity.desired_capacity
  max_size                  = var.asg_capacity.max_size
  min_size                  = var.asg_capacity.min_size
  health_check_type         = "EC2"
  vpc_zone_identifier       = aws_subnet.private_subnet[*].id
  target_group_arns         = [ aws_lb_target_group.application.arn, ]

  launch_template {
    id      = aws_launch_template.application.id
    version = aws_launch_template.application.latest_version
  }
 
  instance_refresh {
    strategy = "Rolling"
    preferences {
      instance_warmup = 120
      min_healthy_percentage = 50
    }
  }

  tag {
    key                 = "Name"
    value               = "${var.project_name}-${var.project_environment}"
    propagate_at_launch = false
  }
  tag {
    key                 = "Project"
    value               = "${var.project_name}"
    propagate_at_launch = false
  }

  tag {
    key                 = "Enironment"
    value               = "${var.project_environment}"
    propagate_at_launch = false
  }
}
 

 resource "aws_lb_target_group" "application" {

  name     = "${var.project_name}-${var.project_environment}"
  port     = var.target_group.port
  protocol = "HTTP"
  vpc_id = aws_vpc.main.id
  deregistration_delay  = var.target_group.deregistration_delay
  target_type = var.target_group.target_type
  health_check {
    enabled = true
    path = var.target_group.path
    protocol = var.target_group.protocol
    interval = var.target_group.interval
    timeout = var.target_group.timeout
    healthy_threshold = var.target_group.healthy_threshold
    unhealthy_threshold = var.target_group.unhealthy_threshold
  }

  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}


resource "aws_lb" "application" {
  
  
  name               = "${var.project_name}-${var.project_environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups = [ aws_security_group.loadbalancer.id ]
  subnets            = aws_subnet.public_subnet[*].id

  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }
}

resource "aws_lb_listener" "application-https" {

  load_balancer_arn = aws_lb.application.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn = data.aws_acm_certificate.amazon_issued.id
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.application.arn
  }
}

resource "aws_lb_listener" "application-http" {

  load_balancer_arn = aws_lb.application.arn
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

resource "aws_route53_record" "production" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = "${var.hostname}.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_lb.application.dns_name
    zone_id                = aws_lb.application.zone_id
    evaluate_target_health = true
  }
}