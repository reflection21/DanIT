output "ip_servers" {
  value = [for instance in aws_instance.public : instance.public_ip]
}