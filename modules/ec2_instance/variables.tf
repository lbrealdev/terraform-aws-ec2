variable "enabled" {
  description = "Enable or disable the EC2 instance creation"
  type        = bool
}

variable "name" {
  description = "Name tag of the EC2 instance"
  type        = string
}

variable "ami" {
  description = "AMI ID for the instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID from the networking data module"
  type        = string
  default     = null
}

variable "security_group_ids" {
  description = "Security group IDs from the networking data module"
  type        = list(string)
  default     = []
}

variable "user_data" {
  description = "User data script. Null leaves user data unset"
  type        = string
  default     = null
  sensitive   = true
}

variable "iam_instance_profile" {
  description = "Name of an existing IAM instance profile. Null leaves the instance without one. This module does not create the profile"
  type        = string
  default     = null

  validation {
    condition     = var.iam_instance_profile == null || length(var.iam_instance_profile) > 0
    error_message = "iam_instance_profile must be the name of an existing instance profile, or null."
  }
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
