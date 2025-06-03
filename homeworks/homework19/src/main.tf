module "vpc" {
  source = "./vpc"
  cidr   = "21.0.0.0"
}

module "sg" {
  source                     = "./sg"
  vpc_id                     = module.vpc.vpc_id
  public_subnets_cidr_blocks = module.vpc.public_subnet_cidr
}

module "ec2" {
  source         = "./ec2"
  public_subnet  = module.vpc.public_subnet
  private_subnet = module.vpc.private_subnet
  public_sg      = module.sg.public_sg
  private_sg     = module.sg.private_sg
}
