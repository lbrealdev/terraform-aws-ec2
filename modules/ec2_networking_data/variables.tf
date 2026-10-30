variable "enabled" {
  description = "Enable or disable the data lookups"
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "ID of the existing VPC"
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "ID of the existing subnet. Must belong to vpc_id"
  type        = string
  default     = null
}

variable "security_group_ids" {
  description = "IDs of existing security groups to fetch. Each must belong to vpc_id"
  type        = list(string)
  default     = []
}
