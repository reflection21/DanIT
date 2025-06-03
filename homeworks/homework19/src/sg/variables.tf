variable "vpc_id" {
  description = "AWS VPC ID"
  type        = string
}
variable "public_subnets_cidr_blocks" {
  description = "List of IDs of public subnets."
  type        = string
}
