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

