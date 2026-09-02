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

