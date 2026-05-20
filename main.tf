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