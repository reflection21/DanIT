variable "public_subnet" {
  description = "public subnet id"
  type        = list(string)
}

variable "private_subnet" {
  description = "private subnet id"
  type        = list(string)
}

variable "public_sg" {
  description = "sg for public servers"
  type        = string
}

variable "private_sg" {
  description = "sg for private servers"
  type        = string
}

variable "count_public_instance" {
  description = "count public servers"
  type        = number
}

variable "count_private_instance" {
  description = "count private servers"
  type        = number
}

variable "deployment_prefix" {
  description = "deployment prefix"
  type        = string
}
