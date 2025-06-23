# servers in public subnets
resource "aws_instance" "public" {
  count           = var.count_public_instance
  ami             = "ami-0c1ac8a41498c1a9c"
  instance_type   = "t3.micro"
  subnet_id       = var.public_subnet[count.index]
  security_groups = [var.public_sg]
  key_name        = aws_key_pair.artem.key_name
  tags = {
    "Name"   = "${var.deployment_prefix}-public-server-${count.index + 1}"
    "Deploy" = "ansible"
  }
}
# servers in private subnets
resource "aws_spot_instance_request" "private" {
  count           = var.count_private_instance
  ami             = "ami-0c1ac8a41498c1a9c"
  instance_type   = "t3.micro"
  subnet_id       = var.private_subnet[count.index]
  security_groups = [var.private_sg]
  spot_price      = "0.04"
  key_name        = aws_key_pair.artem.key_name


  tags = {
    "Name"   = "${var.deployment_prefix}-private-server-${count.index + 1}"
    "Deploy" = "ansible"
  }
}
# public key for servers
resource "aws_key_pair" "artem" {
  key_name   = "step_project3"
  public_key = file("~/.ssh/terraform-server.pub")
}
