terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0"

  backend "s3" {
    bucket         = "betpulse-terraform-state-28890"
    key            = "betpulse/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "betpulse-terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}
