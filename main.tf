module "vpc" {
  source    = "./modules/vpc/"
  cidr_block = var.aws_vpc_cidr
  azs       = var.azs
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

module "security_group" {
  source      = "./modules/security_group/"
  vpc_id      = module.vpc.vpc_id
  http_port   = var.http_port
  https_port  = var.https_port
  ssh_port    = var.ssh_port
}

module "key_pair" {
  source = "./modules/key_pair/main.tf"
}

module "linux_instances" {
  source            = "./modules/instance"
  ami               = var.ami_id_linux
  instance_types    = var.instance_types[0:4] # First four instances
  subnet_id         = module.vpc.private_subnet_ids[0]
  security_group_id = module.security_group.security_group_id
}

module "windows_instance" {
  source            = "./modules/instance"
  ami               = var.ami_id_windows
  instance_types    = [var.instance_types[4]] # Last instance
  subnet_id         = module.vpc.public_subnet_ids[0]
  security_group_id = module.security_group.security_group_id
}
