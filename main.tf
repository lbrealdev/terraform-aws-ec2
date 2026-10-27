provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      resource   = "ec2"
      deployment = "terraform"
    }
  }
}

module "ec2_networking_data" {
  source = "./modules/ec2_networking_data"

  vpc_id            = var.vpc_id
  subnet_id         = var.subnet_id
  security_group_id = var.security_group_id
}

module "ec2_instance" {
  source = "./modules/ec2_instance"

  name              = var.name
  ami               = var.ami
  instance_type     = var.instance_type
  user_data         = var.user_data
  subnet_id         = module.ec2_networking_data.subnet_id
  security_group_id = module.ec2_networking_data.security_group_id
}
