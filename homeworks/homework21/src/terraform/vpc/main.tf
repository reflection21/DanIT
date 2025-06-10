data "aws_availability_zones" "available" {}

locals {
  cidr_part          = trimsuffix(var.cidr, ".0.0")
  public_subnet_cidr = ["${local.cidr_part}.1.0/24", "${local.cidr_part}.2.0/24"]
}

resource "aws_vpc" "my_vpc" {
  cidr_block       = "${var.cidr}/16"
  instance_tenancy = "default"
  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "public" {
  count                   = length(local.public_subnet_cidr)
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = local.public_subnet_cidr[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "myigw"
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    "Name" = "public-rt"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(local.public_subnet_cidr)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public-rt.id
}

