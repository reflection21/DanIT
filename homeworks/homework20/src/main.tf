module "vpc" {
  source = "./vpc"
  cidr   = "21.0.0.0"
}

module "sg" {
  source             = "./sg"
  vpc_id             = module.vpc.vpc_id
  list_of_open_ports = [80, 22]
}

module "ec2" {
  source        = "./ec2"
  public_subnet = module.vpc.public_subnet
  public_sg     = module.sg.public_sg
}
