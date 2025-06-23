variable "public_subnet" {
  description = "public_subnet_id"
  type        = list(string)
}
variable "public_sg" {
  description = "sg for public"
  type        = string
}

variable "count_instance" {
  description = "count"
  type = number
}