# vpc
module "vpc" {
  source               = "./vpc"
  vpc_cidr             = "21.0.0.0/16"
  public_subnets_cidr  = ["21.0.1.0/24", "21.0.2.0/24"]
  private_subnets_cidr = ["21.0.11.0/24", "21.0.12.0/24"]
  deployment_prefix    = "artem"
}
# sg
module "sg" {
  source                     = "./sg"
  vpc_id                     = module.vpc.vpc_id
  list_of_public_open_ports  = [80, 22]
  list_of_private_open_ports = [5000, 22]
  public_subnets_cidr_blocks = module.vpc.public_subnet_cidr
  deployment_prefix          = "artem"
}
# ec2
module "ec2" {
  source                 = "./ec2"
  count_public_instance  = 2
  count_private_instance = 2
  public_subnet          = module.vpc.public_subnet
  private_subnet         = module.vpc.private_subnet
  public_sg              = module.sg.public_sg
  private_sg             = module.sg.private_sg
  deployment_prefix      = "artem"
}
