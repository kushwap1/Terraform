# root-main.tf

provider "aws" {
  region = var.aws_region
}

module "storage" {
  source = "./storage"
  project_name = var.project_name
}

