resource "aws_instance" "public" {
  count           = var.count_instance
  ami             = "ami-0c1ac8a41498c1a9c"
  instance_type   = "t3.micro"
  subnet_id       = var.public_subnet[count.index]
  security_groups = [var.public_sg]
  key_name        = "reflection"
  # user_data       = <<-EOT
  #           #!/bin/bash
  #           apt-get update -y
  #           apt-get install -y docker.io
  #           systemctl start docker
  #           systemctl enable docker
  #           usermod -aG docker ubuntu
  #           docker run -d --name nginx -p 80:80 nginx:latest
  #       EOT
  tags = {
    Name = "nginx-server-${count.index + 1}"
    Team = "dev-${count.index + 1}"
    Team = "prod-${count.index + 1}"
  }
}

resource "aws_key_pair" "public" {
  key_name   = "reflection"
  public_key = file("~/.ssh/terraform-server.pub")
}
