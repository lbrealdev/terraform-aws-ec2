output "vpc_id" {
  description = "ID of the fetched VPC."
  value       = data.aws_vpc.this.id
}

output "subnet_id" {
  description = "ID of the fetched subnet."
  value       = data.aws_subnet.this.id
}

output "security_group_id" {
  description = "ID of the fetched security group."
  value       = data.aws_security_group.this.id
}
