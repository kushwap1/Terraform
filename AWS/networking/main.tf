#----networking/main.tf----

provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {}

resource "aws_vpc" "new" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "vpc-terraform"
  }
}

resource "aws_internet_gateway" "new" {
  vpc_id = aws_vpc.new.id

  tags = {
    Name = "igw-terraform"
  }
}

resource "aws_route_table" "new" {
  vpc_id = aws_vpc.new.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.new.id
  }

  tags = {
    Name = "public-route-terraform"
  }
}

resource "aws_default_route_table" "new" {
  default_route_table_id  = aws_vpc.new.default_route_table_id

  tags = {
    Name = "private-route-terraform"
  }
}

resource "aws_subnet" "new" {
  count                   = 2
  vpc_id                  = aws_vpc.new.id
  cidr_block              = var.public_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "subnet-${count.index + 1}"
  }
}

resource "aws_route_table_association" "new" {
  count          = 2
  subnet_id      = aws_subnet.new.*.id[count.index]
  route_table_id = aws_route_table.new.id
}

resource "aws_security_group" "new" {
  name        = "terraform"
  description = "Used for access to the public instances"
  vpc_id      = aws_vpc.new.id

  #SSH

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.accessip]
  }

  #HTTP

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.accessip]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
