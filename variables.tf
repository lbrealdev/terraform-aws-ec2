variable "aws_region" {
  description = "AWS region for the provider"
  type        = string
  default     = "eu-central-1"
}

variable "prefix_name" {
  description = "Prefix for resource names. Used in format(\"ec2-%s-instance\", prefix_name) when name is null"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

# Networking Configuration
variable "networking_enabled" {
  description = "Enable or disable the networking data lookups"
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "ID of the existing VPC. This module does not create a VPC"
  type        = string

  validation {
    condition     = can(regex("^vpc-", var.vpc_id))
    error_message = "vpc_id must be an existing VPC ID (vpc-...)."
  }
}

variable "subnet_id" {
  description = "ID of the existing subnet where the instance will run. Must belong to vpc_id"
  type        = string

  validation {
    condition     = can(regex("^subnet-", var.subnet_id))
    error_message = "subnet_id must be an existing subnet ID (subnet-...)."
  }
}

variable "security_group_ids" {
  description = "IDs of existing security groups to attach. Each must belong to vpc_id"
  type        = list(string)

  validation {
    condition     = alltrue([for id in var.security_group_ids : can(regex("^sg-", id))])
    error_message = "Each security_group_ids value must be an existing security group ID (sg-...)."
  }
}

# EC2 Instance
variable "instance_enabled" {
  description = "Enable or disable the EC2 instance creation"
  type        = bool
  default     = true
}

variable "name" {
  description = "Name tag of the EC2 instance. Null uses format(\"ec2-%s-instance\", prefix_name)"
  type        = string
  default     = null

  validation {
    condition     = var.name == null || length(var.name) > 0
    error_message = "name must not be empty."
  }
}

variable "user_data" {
  description = "User data script for the instance. Null leaves user data unset"
  type        = string
  default     = null
  sensitive   = true
}

variable "iam_instance_profile" {
  description = "Name of an existing IAM instance profile to attach. Null leaves the instance without one. This stack does not create the profile"
  type        = string
  default     = null

  validation {
    condition     = var.iam_instance_profile == null || length(var.iam_instance_profile) > 0
    error_message = "iam_instance_profile must be the name of an existing instance profile, or null."
  }
}

variable "ami" {
  description = "AMI ID for the instance. Required; there is no default image"
  type        = string

  validation {
    condition     = can(regex("^ami-", var.ami))
    error_message = "ami must be an AMI ID (ami-...)."
  }
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"

  validation {
    condition     = length(var.instance_type) > 0
    error_message = "instance_type must not be empty."
  }
}
