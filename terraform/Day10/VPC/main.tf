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

resource "aws_subnet" "public_subnet_1" {

  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.vpc_cidr_block, 4, 0 )

  map_public_ip_on_launch = true
  availability_zone_id = data.aws_availability_zones.available.zone_ids[0]

  tags = {
    Name = "${var.project_name}-${var.project_environment}-public_1"
    Type = "public"
  }
}

resource "aws_subnet" "public_subnet_2" {

  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.vpc_cidr_block, 4, 1 )

  map_public_ip_on_launch = true
  availability_zone_id = data.aws_availability_zones.available.zone_ids[1]

  tags = {
    Name = "${var.project_name}-${var.project_environment}-public_2"
    Type = "public"
  }
}

resource "aws_subnet" "public_subnet_3" {

  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.vpc_cidr_block, 4, 2 )

  map_public_ip_on_launch = true
  availability_zone_id = data.aws_availability_zones.available.zone_ids[2]

  tags = {
    Name = "${var.project_name}-${var.project_environment}-public_3"
    Type = "public"
  }
}

resource "aws_subnet" "private_subnet_1" {

  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.vpc_cidr_block, 4, 3 )

  map_public_ip_on_launch = false
  availability_zone_id = data.aws_availability_zones.available.zone_ids[0]

  tags = {
    Name = "${var.project_name}-${var.project_environment}-private_1"
    Type = "private"
  }
}

resource "aws_subnet" "private_subnet_2" {

  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.vpc_cidr_block, 4, 4 )

  map_public_ip_on_launch = false
  availability_zone_id = data.aws_availability_zones.available.zone_ids[1]

  tags = {
    Name = "${var.project_name}-${var.project_environment}-private_2"
    Type = "private"
  }
}

resource "aws_subnet" "private_subnet_3" {

  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(var.vpc_cidr_block, 4, 5 )

  map_public_ip_on_launch = false
  availability_zone_id = data.aws_availability_zones.available.zone_ids[2]

  tags = {
    Name = "${var.project_name}-${var.project_environment}-private_3"
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


resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_3" {
  subnet_id      = aws_subnet.public_subnet_3.id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat" {
  domain   = "vpc"
  tags = {
    Name = "${var.project_name}-${var.project_environment}-nat"
  }
}


resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet_2.id

  tags = {
    Name = "${var.project_name}-${var.project_environment}"
  }

  depends_on = [aws_internet_gateway.igw]
}


resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "${var.project_name}-${var.project_environment}-private"
    Type = "private"
  }
}

resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_3" {
  subnet_id      = aws_subnet.private_subnet_3.id
  route_table_id = aws_route_table.private.id
}