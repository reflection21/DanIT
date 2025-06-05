variable "vpc_id" {
  description = "AWS VPC ID"
  type        = string
}
variable "list_of_open_ports" {
  description = "List of open_ports."
  type        = list(number)
}
