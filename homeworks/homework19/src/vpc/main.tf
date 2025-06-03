data "aws_availability_zones" "available" {}

locals {
  cidr_part = trimsuffix(var.cidr, ".0.0")
}

resource "aws_vpc" "my_vpc" {
  cidr_block       = "${var.cidr}/16"
  instance_tenancy = "default"
  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "${local.cidr_part}.1.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "${local.cidr_part}.11.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "public-private"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "myigw"
  }
}

resource "aws_eip" "nat_eip" {
  tags = {
    Name = "nat-eip"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public.id
  tags = {
    Name = "gw NAT"
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
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    "Name" = "private-rt"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private-rt.id
}
