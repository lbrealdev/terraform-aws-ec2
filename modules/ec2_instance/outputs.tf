output "id" {
  description = "ID of the EC2 instance"
  value       = var.enabled ? aws_instance.this[0].id : null
}

output "arn" {
  description = "ARN of the EC2 instance"
  value       = var.enabled ? aws_instance.this[0].arn : null
}

output "private_ip" {
  description = "Private IP of the EC2 instance"
  value       = var.enabled ? aws_instance.this[0].private_ip : null
}

output "public_ip" {
  description = "Public IP of the EC2 instance, if assigned"
  value       = var.enabled ? aws_instance.this[0].public_ip : null
}

output "private_dns" {
  description = "Private DNS name of the EC2 instance"
  value       = var.enabled ? aws_instance.this[0].private_dns : null
}

output "public_dns" {
  description = "Public DNS name of the EC2 instance, if assigned"
  value       = var.enabled ? aws_instance.this[0].public_dns : null
}

output "availability_zone" {
  description = "Availability zone of the EC2 instance"
  value       = var.enabled ? aws_instance.this[0].availability_zone : null
}
