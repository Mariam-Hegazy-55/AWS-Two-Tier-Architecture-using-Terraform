# Call vpc module
module "vpc" {
  source   = "./modules/vpc"
  cidr     = "20.0.0.0/16"
  sub_pub  = ["20.0.1.0/24", "20.0.2.0/24"]
  sub_priv = ["20.0.0.0/24","20.0.3.0/24"]
  azs      = ["eu-west-2a", "eu-west-2b"]

}

#call ec2 module
module "instance1" {
  source           = "./modules/ec2"
  ami              = "ami-0a94c8e4ca2674d5a"
  instance_type    = "t2.micro"
  subnet_id        = module.vpc.public1_id
  sg_id            = [module.vpc.sg_id]
  key              = "my-key"
  private_key_path = "D:\\ITI\\terraform\\final project\\key file\\my-key.pem"
  depends_on       = [module.vpc]

}


module "RDS" {
  source       = "./Modules/RDS"
  db_sg_id     = module.vpc.sg_id
  pri_sub_1_id = module.vpc.private_subnet1
  pri_sub_2_id = module.vpc.private_subnet2
  db_username  = var.db_username
  db_password  = var.db_password
  db_sub_name  = var.db_sub_name
}










/*
module "rds" {
  source = "./modules/rds"
  vpc_id = module.vpc.vpc_id
  private_subnets = [ module.vpc.private_subnet1, module.vpc.private_subnet2 ]
  ec2-sg-id = module.vpc.sg_id
  
}
/*
module "instance2" {
  source           = "./modules/ec2"
  ami              = "ami-0a94c8e4ca2674d5a"
  instance_type    = "t2.micro"
  subnet_id        = module.vpc.public2_id
  sg_id            = [module.vpc.sg_id]
  key              = "my-key"
  private_key_path = "D:\\ITI\\terraform\\final project\\key file\\my-key.pem"
  depends_on       = [module.vpc]
}


module "alb" {
  source     = "./modules/load_balancer"
  subnets    = [module.vpc.public1_id, module.vpc.public2_id]
  vpc_id     = module.vpc.vpc_id
  instances  = [module.instance2.instance_id, module.instance2.instance_id]
  depends_on = [module.instance1, module.instance2, module.vpc]
}
*/
