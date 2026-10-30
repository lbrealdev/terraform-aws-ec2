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

  enabled            = var.networking_enabled
  vpc_id             = var.vpc_id
  subnet_id          = var.subnet_id
  security_group_ids = var.security_group_ids
}

module "ec2_instance" {
  source = "./modules/ec2_instance"

  # --- Instance ---
  enabled       = var.instance_enabled
  name          = local.instance_name
  ami           = var.ami
  instance_type = var.instance_type

  # --- Access ---
  user_data            = var.user_data
  iam_instance_profile = var.iam_instance_profile

  # --- Network ---
  subnet_id          = module.ec2_networking_data.subnet_id
  security_group_ids = module.ec2_networking_data.security_group_ids

  tags = var.tags
}

check "instance_requires_networking" {
  assert {
    condition     = !var.instance_enabled || (var.networking_enabled && length(var.security_group_ids) > 0)
    error_message = "instance_enabled requires networking_enabled and at least one security_group_ids value."
  }
}
