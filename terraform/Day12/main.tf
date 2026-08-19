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

# Security groupt for Bastion

resource "aws_security_group" "backend" {
  name        = "${var.project_name}-${var.project_environment}-backend"
  description = "${var.project_name}-${var.project_environment}-backend"
  vpc_id = aws_vpc.main.id
  
  egress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups  = [ aws_security_group.loadbalancer.id ]
  }
  
  egress {
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


# allow 80 from anywhere

#resource "aws_security_group_rule" "backend_http_allow_from_all" {

  count             = var.debug_backend ? 1 : 0

  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.backend.id
}

resource "aws_instance" "webserver" {

  ami                    = data.aws_ami.application.image_id
  instance_type          = "t3.micro"
  key_name               = "vpk_devops"
  vpc_security_group_ids = [ aws_security_group.backend.id ]
  subnet_id = aws_subnet.public_subnet[0].id
  tags = {
    Name        = "${var.project_name}-${var.project_environment}-webserver"
  }

  lifecycle {
    create_before_destroy = true
  }
}
