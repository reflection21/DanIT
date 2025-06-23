output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "public_subnet_cidr" {
  value = aws_subnet.public.*.cidr_block
}

output "public_subnet" {
  value = aws_subnet.public.*.id
}

output "private_subnet" {
  value = aws_subnet.private.*.id
}
