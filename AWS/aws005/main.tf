# Creating VPC
module "vpc" {
  source      = "../modules/vpc"
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
  source  = "../modules/SG"
  vpc_id  = module.vpc.vpc_id
  project = var.project
}

# Create Application Load Balancer
module "alb" {
  source         = "../modules/alb"
  project        = var.project
  environment    = var.environment
  alb_sg_id      = module.sg.alb_sg_id
  PUB_SUB_1_A_ID = module.vpc.PUB_SUB_1_A_ID
  PUB_SUB_2_B_ID = module.vpc.PUB_SUB_2_B_ID
  vpc_id         = module.vpc.vpc_id
}

# Crating Auto Scaling Group
module "asg" {
  source         = "../modules/asg"
  project        = var.project
  environment    = var.environment
  app_sg_id      = module.sg.app_sg_id 
  PRI_SUB_3_A_ID = module.vpc.PRI_SUB_3_A_ID
  PRI_SUB_4_B_ID = module.vpc.PRI_SUB_4_B_ID
  TG_ARN         = module.alb.TG_ARN

}

# Create Cloudfront Distribution 
module "cloudfront" {
  source                  = "../modules/cloud-front"
  certificate_domain_name = var.certificate_domain_name
  alb_domain_name         = module.alb.alb_domain_name
  additional_domain_name  = var.additional_domain_name
  project                 = var.project
  environment             = var.environment
}


# Add record in Route 53 
module "route53" {
  source                    = "../modules/route-s3"
  record_name               = var.record_name
  cloudfront_domain_name    = module.cloudfront.cloudfront_domain_name
  cloudfront_hosted_zone_id = module.cloudfront.cloudfront_hosted_zone_id
}