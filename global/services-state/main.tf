variable "region" {}
variable "project-name" {}
variable "terraform_credentials_file" {}
variable "account-id" {}

module "aws-arch-env-sample" {
   source = "git::ssh://git@github.com/phcaguiar/aws-arch-env-sample.git"
   project = "${var.project-name}"
}

provider "aws" {
   shared_credentials_file = "${var.terraform_credentials_file}"
   alias = "prod"
   profile = "${var.project-name}-admin"
   region = "${var.region}"
}

module "s3" {
   source = "./modules/s3"
   project-name = "${var.project-name}"
   account-id = "${module.aws-arch-env-sample.accountid}"
   #account-id = "${var.account-id}"
}
