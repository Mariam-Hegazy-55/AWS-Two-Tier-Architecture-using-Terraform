# Call vpc module
module "vpc" {
  source   = "./modules/vpc"
  cidr     = var.cidr
  sub_pub  = var.sub_pub
  sub_priv = var.sub_priv
  azs      = ["eu-west-2a", "eu-west-2b"]

}

#call ec2 module
module "instances" {
  source        = "./modules/ec2"
  ami           = "ami-0a94c8e4ca2674d5a"
  instance_type = "t2.micro"
  subnet_ids    = [module.vpc.public1_id, module.vpc.public2_id]
  key              = "mariam-key"
  private_key_path = "D:\\ITI\\terraform\\final project\\key file\\mariam-key.pem"
  depends_on       = [module.vpc]
  db_name          = var.db_name
  db_password      = var.db_password
  db_user          = var.db_username
  db_host          = module.rds.rds-endpoint
  vpc_id           = module.vpc.vpc_id

}


module "rds" {
  source      = "./Modules/RDS"
  db_sub_name = var.db_sub_name
  subnet_ids  = [module.vpc.public1_id, module.vpc.public2_id]
  db_username = var.db_username
  db_password = var.db_password
  db_name     = var.db_name
  vpc_id      = module.vpc.vpc_id
  sg-ec2-id   = module.vpc.sg_id
}



module "alb" {
  source    = "./modules/load_balancer"
  subnets   = [module.vpc.public1_id, module.vpc.public2_id]
  vpc_id    = module.vpc.vpc_id
  instances = module.instances.instance_ids
  alb_sg_id = module.instances.alb_sg_id
  depends_on = [ module.instances ]
}











