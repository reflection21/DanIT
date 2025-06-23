terraform {
  source = "../../terraform/modules//ec2/"
}

include "root" {
  path   = find_in_parent_folders()
  expose = true # include variables of parents file
}
# mock value for plan
dependency "vpc" {
  config_path                             = "../vpc"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "providers", "terragrunt-info", "show"]
  mock_outputs = {
    public_subnet  = ["21.0.1.0/24"]
    private_subnet = ["21.0.11.0/24"]
  }
}
dependency "sg" {
  config_path                             = "../sg"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan", "providers", "terragrunt-info", "show"]
  mock_outputs = {
    public_sg  = "sg-04130675dc6de0239"
    private_sg = "sg-0e5ed8bae440088a5"
  }
}

inputs = {
  count_public_instance  = 1
  count_private_instance = 1
  public_subnet          = dependency.vpc.outputs.public_subnet
  private_subnet         = dependency.vpc.outputs.private_subnet
  public_sg              = dependency.sg.outputs.public_sg
  private_sg             = dependency.sg.outputs.private_sg
}
