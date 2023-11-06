module "vpc" {
  source            = "../modules/vpc"
  region = var.region
  project_name      = var.project_name

  vpc_cidr          = var.vpc_cidr
  public_subnet_1a  = var.public_subnet_1a
  public_subnet_2b  = var.public_subnet_2b
  private_subnet_3a = var.private_subnet_3a
  private_subnet_4b = var.private_subnet_4b
  private_subnet_5a = var.private_subnet_5a
  private_subnet_6b = var.private_subnet_6b
}

module "nat" {
  source               = "../modules/nat"
  public_subnet_1a_id  = module.vpc.public_subnet_1a_id
  igw_id               = module.vpc.igw_id
  public_subnet_2b_id  = module.vpc.public_subnet_2b_id
  vpc_id               = module.vpc.vpc_id
  private_subnet_3a_id = module.vpc.private_subnet_3a_id
  private_subnet_4b_id = module.vpc.private_subnet_4b_id
  private_subnet_5a_id = module.vpc.private_subnet_5a_id
  private_subnet_6b_id = module.vpc.private_subnet_6b_id
}
module "security-group" {
  source = "../modules/security-group"
  vpc_id = module.vpc.vpc_id
}
/*
# creating Key for instances
module "key" {
  source = "../modules/key"
}
*/

# Creating Application Load balancer
module "alb" {
  source         = "../modules/alb"
  project_name   = module.vpc.project_name
  alb_sg_id      = module.security-group.alb_sg_id
  public_subnet_1a_id = module.vpc.public_subnet_1a_id
  public_subnet_2b_id = module.vpc.public_subnet_2b_id
  vpc_id         = module.vpc.vpc_id
}

module "asg" {
  source         = "../modules/asg"
  project_name   = module.vpc.project_name
  key_name       = var.key_name
  client_sg_id   = module.security-group.client_sg_id
  private_subnet_3a_id = module.vpc.private_subnet_3a_id
  private_subnet_4b_id = module.vpc.private_subnet_4b_id
  tg_arn         = module.alb.tg_arn

}

# creating RDS instance

module "rds" {
  source         = "../modules/rds"
  db_sg_id       = module.security-group.db_sg_id
  private_subnet_5a_id = module.vpc.private_subnet_5a_id
  private_subnet_6b_id = module.vpc.private_subnet_6b_id
  db_username    = var.db_username
  db_password    = var.db_password
}
/*
# create cloudfront distribution 
module "cloudfront" {
  source = "../modules/cloudfront"
  
  alb_domain_name = module.alb.alb_dns_name 
  
  additional_domain_name = var.additional_domain_name 
  project_name = module.vpc.project_name
}


# Add record in route 53 hosted zone

module "route53" {
  source = "../modules/route53"
  cloudfront_domain_name = module.cloudfront.cloudfront_domain_name
  cloudfront_hosted_zone_id = module.cloudfront.cloudfront_hosted_zone_id

}

*/