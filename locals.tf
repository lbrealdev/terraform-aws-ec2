locals {
  instance_name = coalesce(var.name, format("ec2-%s-instance", var.prefix_name))
}
