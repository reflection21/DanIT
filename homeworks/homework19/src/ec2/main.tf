resource "aws_instance" "public" {
  ami                         = "ami-0c1ac8a41498c1a9c"
  instance_type               = "t3.micro"
  subnet_id                   = var.public_subnet
  security_groups             = [var.public_sg]
  associate_public_ip_address = true
  key_name                    = "deployer-key"
  tags = {
    Name = "public-server"
  }
}
resource "aws_instance" "private" {
  ami                         = "ami-0c1ac8a41498c1a9c"
  instance_type               = "t3.micro"
  subnet_id                   = var.private_subnet
  security_groups             = [var.private_sg]
  associate_public_ip_address = false
  key_name                    = "deployer-key"
  tags = {
    Name = "private-server"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("~/.ssh/terraform-server.pub")
}
