module "jt_vpc" {

  source      = "./modules/vpc"
  vpc_cidr    = var.vpc_cidr
  subnet_cidr = var.subnet_cidr


}

module "sg" {
  source = "./modules/sg"
  vpc_id = module.jt_vpc.vpc_idr

}

module "ec2" {
  source  = "./modules/ec2"
  sg_id   = module.sg.sg
  subnets = module.jt_vpc.subnet_ids
}

module "jt-alb" {
    source = "./modules/alb"
    sg_id = module.sg.sg
    subnets = module.jt_vpc.subnet_ids
    vpc_id = module.jt_vpc.vpc_idr
    instance = module.ec2.instances
  
}

module "jt-lb-targetgroup" {
  source = "./modules/alb"
  vpc_id = module.jt_vpc.vpc_idr
  sg_id = module.sg.sg
  subnets = module.jt_vpc.subnet_ids
  instance = module.ec2.instances
}