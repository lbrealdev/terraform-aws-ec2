variable "name" {
  description = "Name tag of the EC2 instance."
  type        = string
}

variable "ami" {
  description = "AMI ID for the instance."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID from the networking data module."
  type        = string
}

variable "security_group_id" {
  description = "Security group ID from the networking data module."
  type        = string
}

variable "user_data" {
  description = "User data script. Null leaves user data unset."
  type        = string
  default     = null
  sensitive   = true
}
