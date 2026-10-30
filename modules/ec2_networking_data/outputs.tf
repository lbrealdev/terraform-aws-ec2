output "vpc_id" {
  description = "ID of the fetched VPC"
  value       = var.enabled ? data.aws_vpc.this[0].id : null
}

output "subnet_id" {
  description = "ID of the fetched subnet"
  value       = var.enabled ? data.aws_subnet.this[0].id : null
}

output "security_group_ids" {
  description = "IDs of the fetched security groups"
  value       = var.enabled ? [for id in var.security_group_ids : data.aws_security_group.this[id].id] : []
}

output "enabled" {
  description = "Whether the module is enabled"
  value       = var.enabled
}
