data "aws_s3_bucket" "s3" {
  bucket = var.s3_bucket_name
}
module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr   = var.vpc_cidr
  region   = var.region
}

module "security" {
  source         = "./modules/security"
  vpc_id         = module.vpc.vpc_id
  alb_sg_cidr    = var.alb_sg_cidr
}

module "alb" {
  source = "./modules/alb"
  vpc_id = module.vpc.vpc_id

  alb_security_groups = module.security.alb_security_group_ids
  alb_subnets         = module.vpc.public_subnets
  alb_log_bucket      = data.aws_s3_bucket.s3.bucket

  enable_https        = false
}

module "asg" {
  source              = "./modules/asg"
  vpc_id              = module.vpc.vpc_id
  private_subnets     = module.vpc.private_subnets
  security_group_ids  = module.security.ec2_security_group_ids
  alb_target_group    = module.alb.target_group_arn
  launch_template_name= var.launch_template_name
  image_id            = var.image_id
  instance_type       = var.instance_type
}

module "rds" {
  source               = "./modules/rds"
  vpc_id               = module.vpc.vpc_id
  private_subnets      = module.vpc.private_subnets
  ec2_security_group_id= module.security.rds_security_group_id
  db_name              = var.db_name
  db_username          = var.db_username
  db_password          = var.db_password
}

module "iam" {
  source                = "./modules/iam"
  ec2_role_name         = var.ec2_role_name
  ec2_policy_name       = var.ec2_policy_name
  instance_profile_name = var.instance_profile_name
  s3_bucket_arn         = var.s3_bucket_arn
}
