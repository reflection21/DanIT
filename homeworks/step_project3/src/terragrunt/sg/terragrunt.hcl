terraform {
  source = "../../terraform/modules/networking//sg/"
}


include "root" {
  path   = find_in_parent_folders()
  expose = true # include variables of parents file
}

dependency "vpc" {
  config_path                             = "../vpc"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "providers", "terragrunt-info", "show"]
  mock_outputs = {
    public_subnets_cidr_blocks = ["21.0.11.0/24", "21.0.12.0/24"]
    vpc_id                     = "123545234"
    list_of_public_open_ports  = [80, 22,]
    list_of_private_open_ports = [22]
  }
}

inputs = {
  vpc_id                     = dependency.vpc.outputs.vpc_id
  public_subnets_cidr_blocks = dependency.vpc.outputs.public_subnet_cidr
  list_of_public_open_ports  = [
    { port = 22, protocol = "tcp" },
    { port = 80, protocol = "tcp" },
    { port = 50000, protocol = "tcp" },
    { port = -1,  protocol = "icmp" }
  ]
  list_of_private_open_ports = [
    { port = 22, protocol = "tcp" },
    { port = -1,  protocol = "icmp" }    
  ]
}
