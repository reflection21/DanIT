# public sg
resource "aws_security_group" "public" {
  name   = "public-sg"
  vpc_id = var.vpc_id


  dynamic "ingress" {
    for_each = var.list_of_public_open_ports
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "${var.deployment_prefix}-public-sg"
  }
}
# private sg
resource "aws_security_group" "private" {
  name   = "private-sg"
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.list_of_private_open_ports
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = var.public_subnets_cidr_blocks
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "${var.deployment_prefix}-private-sg"
  }
}
