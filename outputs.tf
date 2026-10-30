output "vpc_id" {
  description = "VPC ID the instance was placed in"
  value       = module.ec2_networking_data.vpc_id
}

output "subnet_id" {
  description = "Subnet ID the instance was placed in"
  value       = module.ec2_networking_data.subnet_id
}

output "security_group_ids" {
  description = "Security group IDs attached to the instance"
  value       = module.ec2_networking_data.security_group_ids
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = module.ec2_instance.id
}

output "instance_arn" {
  description = "ARN of the EC2 instance"
  value       = module.ec2_instance.arn
}

output "private_ip" {
  description = "Private IP of the EC2 instance"
  value       = module.ec2_instance.private_ip
}

output "public_ip" {
  description = "Public IP of the EC2 instance, if assigned"
  value       = module.ec2_instance.public_ip
}

output "private_dns" {
  description = "Private DNS name of the EC2 instance"
  value       = module.ec2_instance.private_dns
}

output "public_dns" {
  description = "Public DNS name of the EC2 instance, if assigned"
  value       = module.ec2_instance.public_dns
}

output "availability_zone" {
  description = "Availability zone of the EC2 instance"
  value       = module.ec2_instance.availability_zone
}
