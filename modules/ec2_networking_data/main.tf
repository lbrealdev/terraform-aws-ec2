data "aws_vpc" "this" {
  id = var.vpc_id
}

data "aws_subnet" "this" {
  id = var.subnet_id

  lifecycle {
    postcondition {
      condition     = self.vpc_id == var.vpc_id
      error_message = "subnet_id ${var.subnet_id} is not in vpc_id ${var.vpc_id}."
    }
  }
}

data "aws_security_group" "this" {
  id = var.security_group_id

  lifecycle {
    postcondition {
      condition     = self.vpc_id == var.vpc_id
      error_message = "security_group_id ${var.security_group_id} is not in vpc_id ${var.vpc_id}."
    }
  }
}
