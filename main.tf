module "vpc" {
    source ="./modules/vpc"

    project_name = var.project_name
    environment  = var.environment
    aws_region   = var.aws_region
}

module "security" {
    source = "./modules/security"

    project_name = var.project_name
    environment  = var.environment
    vpc_id       = module.vpc.vpc_id
}

module "auth" {
    source = "./modules/auth"

    project_name = var.project_name
    environment  = var.environment
}

module "compute" {
    source = "./modules/compute"

     project_name              = var.project_name
     environment               = var.environment
     aws_region                = var.aws_region
     vpc_id                    = module.vpc.vpc_id
     public_subnet_1_id        = module.vpc.public_subnet_1_id
     public_subnet_2_id        = module.vpc.public_subnet_2_id
     private_subnet_1_id       = module.vpc.private_subnet_1_id
     private_subnet_2_id       = module.vpc.private_subnet_2_id
     alb_security_group_id     = module.security.alb_security_group_id
     fargate_security_group_id = module.security.fargate_security_group_id
     certificate_arn           = var.certificate_arn
}