# availability zones
data "aws_availability_zones" "available" {}
# vpc
resource "aws_vpc" "my_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    "Name" = "${var.deployment_prefix}-vpc"
  }
}
# public subnets
resource "aws_subnet" "public" {
  count                   = length(var.public_subnets_cidr)
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_subnets_cidr[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    "Name" = "${var.deployment_prefix}-public-subnet-${count.index + 1}"
  }
}
# private subnets
resource "aws_subnet" "private" {
  count             = length(var.private_subnets_cidr)
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.private_subnets_cidr[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    "Name" = "${var.deployment_prefix}-private-subnet-${count.index + 1}"
  }
}
# igw
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    "Name" = "${var.deployment_prefix}-myigw"
  }
}
# static ip for nat
resource "aws_eip" "nat_eip" {
  count = length(var.public_subnets_cidr)
  tags = {
    "Name" = "${var.deployment_prefix}-nat-eip-${count.index + 1}"
  }
}
# nat for private subnets
resource "aws_nat_gateway" "nat" {
  count         = length(var.public_subnets_cidr)
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  tags = {
    "Name" = "${var.deployment_prefix}-nat-${count.index + 1}"
  }
}
# public route table
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    "Name" = "${var.deployment_prefix}-public-rt"
  }
}
# private route table
resource "aws_route_table" "private-rt" {
  count  = length(var.public_subnets_cidr)
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat[count.index].id
  }
  tags = {
    "Name" = "${var.deployment_prefix}-private-rt-${count.index + 1}"
  }
}
# link public-rt to public subnets
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public-rt.id
}
# link private-rt to private subnets
resource "aws_route_table_association" "private" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private-rt[count.index].id
}
