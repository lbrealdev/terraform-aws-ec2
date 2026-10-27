variable "vpc_id" {
  description = "ID of the existing VPC."
  type        = string
}

variable "subnet_id" {
  description = "ID of the existing subnet. Must belong to vpc_id."
  type        = string
}

variable "security_group_id" {
  description = "ID of the existing security group. Must belong to vpc_id."
  type        = string
}
