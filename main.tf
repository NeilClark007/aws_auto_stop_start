terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.5.0"
    }
  }
}
 
provider "aws" {
  region = var.aws_region
}

#queries AWS for the current caller identity used by terraform to deploy to AWS
#this then drops the account_id in the outputs.tf file to be used in other modules
data "aws_caller_identity" "current" {}

#this calls the code to run in the IAM module
module "iam" {
    source = "./modules/IAM"
    ssm_role_name = var.ssm_role_name
}

#this calls the code to run in the resource_group module
module "resource_groups" {
    source = "./modules/Resource_Groups"
}

#this calls the code to run in the maintenace_windows module 
module "maintenance_windows" {
    source = "./modules/maintenance_windows"
    ssm_role_name = var.ssm_role_name #this makes the varible avaliable for use in the module check ./maintenance_windows/varibles.tf
    account_id = data.aws_caller_identity.current.account_id #this makes the varible avaliable for use in the module check ./maintenance_windows/varibles.tf
}