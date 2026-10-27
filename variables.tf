variable "aws_region" {
  description = "AWS region for the provider."
  type        = string
  default     = "eu-central-1"
}

variable "vpc_id" {
  description = "ID of the existing VPC. This module does not create a VPC."
  type        = string

  validation {
    condition     = can(regex("^vpc-", var.vpc_id))
    error_message = "vpc_id must be an existing VPC ID (vpc-...)."
  }
}

variable "subnet_id" {
  description = "ID of the existing subnet where the instance will run. Must belong to vpc_id."
  type        = string

  validation {
    condition     = can(regex("^subnet-", var.subnet_id))
    error_message = "subnet_id must be an existing subnet ID (subnet-...)."
  }
}

variable "security_group_id" {
  description = "ID of the existing security group to attach. Must belong to vpc_id."
  type        = string

  validation {
    condition     = can(regex("^sg-", var.security_group_id))
    error_message = "security_group_id must be an existing security group ID (sg-...)."
  }
}

variable "name" {
  description = "Name tag of the EC2 instance."
  type        = string

  validation {
    condition     = length(var.name) > 0
    error_message = "name must not be empty."
  }
}

variable "user_data" {
  description = "User data script for the instance. Null leaves user data unset."
  type        = string
  default     = null
  sensitive   = true
}

variable "ami" {
  description = "AMI ID for the instance. Required; there is no default image."
  type        = string

  validation {
    condition     = can(regex("^ami-", var.ami))
    error_message = "ami must be an AMI ID (ami-...)."
  }
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t3.micro"

  validation {
    condition     = length(var.instance_type) > 0
    error_message = "instance_type must not be empty."
  }
}
