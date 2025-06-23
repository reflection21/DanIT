terraform {
  source = "../../terraform/modules/networking//vpc/"
}


include "root" {
  path   = find_in_parent_folders()
  expose = true # include variables of parents file
}

inputs = {
  vpc_cidr             = "21.0.0.0/16"
  public_subnets_cidr  = ["21.0.1.0/24"]
  private_subnets_cidr = ["21.0.11.0/24"]
}
