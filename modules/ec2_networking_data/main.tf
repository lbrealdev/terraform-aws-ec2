data "aws_vpc" "this" {
  count = var.enabled ? 1 : 0
  id    = var.vpc_id
}

data "aws_subnet" "this" {
  count = var.enabled ? 1 : 0
  id    = var.subnet_id

  lifecycle {
    postcondition {
      condition     = self.vpc_id == var.vpc_id
      error_message = "subnet_id ${var.subnet_id} is not in vpc_id ${var.vpc_id}."
    }
  }
}

data "aws_security_group" "this" {
  for_each = var.enabled ? toset(var.security_group_ids) : toset([])

  id = each.value

  lifecycle {
    postcondition {
      condition     = self.vpc_id == var.vpc_id
      error_message = "security_group_id ${each.value} is not in vpc_id ${var.vpc_id}."
    }
  }
}
