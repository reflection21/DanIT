variable "vpc_cidr" {
  description = "CIDR VPC range"
  type        = string
}

variable "public_subnets_cidr" {
  description = "CIDR public subnets range"
  type        = list(string)
}

variable "private_subnets_cidr" {
  description = "CIDR private subnets range"
  type        = list(string)
}

variable "deployment_prefix" {
  description = "deployment-prefix"
  type        = string
}
