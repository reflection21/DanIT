variable "vpc_id" {
  description = "AWS VPC ID"
  type        = string
}
variable "public_subnets_cidr_blocks" {
  description = "public subnets cidr blocks"
  type        = list(string)
}

variable "list_of_private_open_ports" {
  description = "List of private open_ports."
  type = list(object({
    port     = number
    protocol = string
  }))
}

variable "list_of_public_open_ports" {
  description = "List of public open_ports."
  type = list(object({
    port     = number
    protocol = string
  }))
}

variable "deployment_prefix" {
  description = "deployment-prefix"
  type        = string
}
