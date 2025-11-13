variable "project_id" {
  type        = string
  description = "Project id used for billing"
  default     = "cmtr-959pompn"
}

variable "vpc_id" {
  type        = string
  description = "VPC id "
  default     = ""
}

variable "allowed_ip_range" {
  description = "list of IP address range for secure access"
  type        = list(string)
  default     = ["0.0.0.0"]
}

variable "ssh_security_group_name" {
  description = "SSH Security Group name"
  type        = string
  default     = ""
}

variable "public_http_security_group_name" {
  description = "Public HTTP Security Group name"
  type        = string
  default     = ""
}

variable "private_http_security_group_name" {
  description = "Private HTTP Security Group name"
  type        = string
  default     = ""
}