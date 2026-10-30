output "id" {
  description = "ID of the EC2 instance."
  value       = aws_instance.this.id
}

output "arn" {
  description = "ARN of the EC2 instance."
  value       = aws_instance.this.arn
}

output "private_ip" {
  description = "Private IP of the EC2 instance."
  value       = aws_instance.this.private_ip
}

output "public_ip" {
  description = "Public IP of the EC2 instance, if the subnet assigns one."
  value       = aws_instance.this.public_ip
}
