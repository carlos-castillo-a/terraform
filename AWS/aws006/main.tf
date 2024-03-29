# Creating VPC
module "vpc" {
  source      = "./modules/vpc"
  project     = var.project
  environment = var.environment

  VPC_CIDR         = var.VPC_CIDR
  PUB_SUB_1_A_CIDR = var.PUB_SUB_1_A_CIDR
  PUB_SUB_2_B_CIDR = var.PUB_SUB_2_B_CIDR
  PRI_SUB_3_A_CIDR = var.PRI_SUB_3_A_CIDR
  PRI_SUB_4_B_CIDR = var.PRI_SUB_4_B_CIDR
  PRI_SUB_5_A_CIDR = var.PRI_SUB_5_A_CIDR
  PRI_SUB_6_B_CIDR = var.PRI_SUB_6_B_CIDR
}

# Create Security Groups
module "sg" {
  source  = "./modules/sg"
  vpc_id  = module.vpc.vpc_id
  project = var.project
}

# Create Application Load Balancer
module "alb" {
  source          = "./modules/alb"
  project         = var.project
  environment     = var.environment
  alb_sg_id       = module.sg.alb_sg_id
  PUB_SUB_1_A_ID  = module.vpc.PUB_SUB_1_A_ID
  PUB_SUB_2_B_ID  = module.vpc.PUB_SUB_2_B_ID
  vpc_id          = module.vpc.vpc_id
  certificate_arn = var.certificate_arn
}

# Crating Auto Scaling Group
module "ecs" {
  source         = "./modules/ecs"
  project        = var.project
  environment    = var.environment
  app_sg_id      = module.sg.app_sg_id
  PRI_SUB_3_A_ID = module.vpc.PRI_SUB_3_A_ID
  PRI_SUB_4_B_ID = module.vpc.PRI_SUB_4_B_ID
  USERS_TG_ARN   = module.alb.USERS_TG_ARN
  THREADS_TG_ARN = module.alb.THREADS_TG_ARN
  POSTS_TG_ARN   = module.alb.POSTS_TG_ARN
  users_image    = var.users_image
  threads_image  = var.threads_image
  posts_image    = var.posts_image
}

# Create Cloudfront Distribution 
module "cloudfront" {
  source                  = "./modules/cloudfront"
  certificate_domain_name = var.certificate_domain_name
  alb_domain_name         = module.alb.alb_domain_name
  additional_domain_name  = var.additional_domain_name
  project                 = var.project
  environment             = var.environment
}


# Add record in Route 53 
module "route53" {
  source                    = "./modules/route53"
  record_name               = var.record_name
  cloudfront_domain_name    = module.cloudfront.cloudfront_domain_name
  cloudfront_hosted_zone_id = module.cloudfront.cloudfront_hosted_zone_id
}