variable "private_subnet" {
  description = "private_subnet_id"
  type        = string
}

variable "public_subnet" {
  description = "public_subnet_id"
  type        = string
}
variable "public_sg" {
  description = "sg for public"
  type        = string
}
variable "private_sg" {
  description = "sg for private"
  type        = string
}

