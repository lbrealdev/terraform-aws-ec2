output "vpc_id" {
  description = "VPC ID the instance was placed in."
  value       = module.ec2_networking_data.vpc_id
}

output "subnet_id" {
  description = "Subnet ID the instance was placed in."
  value       = module.ec2_networking_data.subnet_id
}

output "security_group_id" {
  description = "Security group ID attached to the instance."
  value       = module.ec2_networking_data.security_group_id
}

output "instance_id" {
  description = "ID of the EC2 instance."
  value       = module.ec2_instance.id
}

output "instance_arn" {
  description = "ARN of the EC2 instance."
  value       = module.ec2_instance.arn
}

output "private_ip" {
  description = "Private IP of the EC2 instance."
  value       = module.ec2_instance.private_ip
}

output "public_ip" {
  description = "Public IP of the EC2 instance, if the subnet assigns one."
  value       = module.ec2_instance.public_ip
}
