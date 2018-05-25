variable "region" {}
variable "project-name" {}
variable "terraform_credentials_file" {}
variable "environment" {}
variable "cidrblockvpc" {}

#terraform {
#  backend "s3" {
#    bucket = "${var.project-name}-teste"
#    key    = "tfstate/terraform.tfstate"
#    region = "${var.region}"
#    shared_credentials_file = "${var.terraform_credentials_file}"
#    region = "sa-east-1"
#    shared_credentials_file = ".config/credentials"
#    access_key = ""
#    secret_key = ""
#  }
#}

provider "aws" {
   shared_credentials_file = "${var.terraform_credentials_file}"
   alias = "${var.environment}"
   profile = "${var.project-name}"
   region = "${var.region}"
}

module "vpc" {
   source = "./modules/vpc"
   project-name = "${var.project-name}"
   cidrblockvpc = "${var.cidrblockvpc}"
}

module "subnets" {
   source = "./modules/subnets"
   project-name = "${var.project-name}"
   vpcid = "${module.vpc.vpcid}"
   region = "${var.region}"
}

module "routes" {
   source = "./modules/routes"
   project-name = "${var.project-name}"
   vpcid = "${module.vpc.vpcid}"
}

#module "instances" {
#   source = "./modules/instances"
#   project-name = "${var.project-name}"
#}
