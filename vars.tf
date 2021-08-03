variable "project_name" {
  type        = string
  description = "Project name"
  default     = "example"
}

variable "instance_type" {
  type        = string
  description = "AWS instance type"
  default     = "t3.nano"
}

variable "public_subnet_id" {
  type        = string
  description = "AWS public subnet ID"
  default     = "CHANGEME"
}

variable "private_subnet_id" {
  type        = string
  description = "AWS private subnet ID"
  default     = "CHANGEME"
}

variable "vpc_id" {
  type        = string
  description = "AWS VPC ID"
  default     = "CHANGEME"
}
