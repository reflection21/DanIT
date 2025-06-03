output "public_sg" {
  value = aws_security_group.public.id
}

output "private_sg" {
  value = aws_security_group.private.id
}
