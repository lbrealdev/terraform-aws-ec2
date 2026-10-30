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

variable "key_name" {
  description = "Name of an existing EC2 key pair. Null leaves the instance without a key pair"
  type        = string
  default     = null
}

variable "associate_public_ip_address" {
  description = "Associate a public IP address with the instance. Null uses the subnet MapPublicIpOnLaunch setting"
  type        = bool
  default     = null
}

variable "monitoring" {
  description = "Enable detailed monitoring"
  type        = bool
  default     = false
}

variable "root_block_device" {
  description = "Root EBS volume settings. Defaults to 30 GiB encrypted gp3"
  type = object({
    volume_size = optional(number, 30)
    volume_type = optional(string, "gp3")
    encrypted   = optional(bool, true)
  })
  default = {}

  validation {
    condition     = contains(["standard", "gp2", "gp3", "io1", "io2"], var.root_block_device.volume_type)
    error_message = "root_block_device.volume_type must be one of: standard, gp2, gp3, io1, io2."
  }

  validation {
    condition     = var.root_block_device.volume_size > 0
    error_message = "root_block_device.volume_size must be greater than 0."
  }
}

variable "metadata_options" {
  description = "Instance metadata options. IMDSv2 is required by default"
  type = object({
    http_endpoint               = optional(string, "enabled")
    http_tokens                 = optional(string, "required")
    http_put_response_hop_limit = optional(number, 1)
    instance_metadata_tags      = optional(string)
  })
  default = {}

  validation {
    condition     = contains(["required", "optional"], var.metadata_options.http_tokens)
    error_message = "metadata_options.http_tokens must be \"required\" or \"optional\"."
  }

  validation {
    condition     = contains(["enabled", "disabled"], var.metadata_options.http_endpoint)
    error_message = "metadata_options.http_endpoint must be \"enabled\" or \"disabled\"."
  }
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
