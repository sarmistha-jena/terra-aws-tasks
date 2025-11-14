variable "project_id" {
  type        = string
  description = "Project identifier for tagging"
  default     = "cmtr-959pompn"
}

variable "aws_launch_template_name" {
  type        = string
  description = "Launch template name"
  default     = "cmtr-959pompn-template"
}

# variable "iam_instance_profile_name" {
#   type        = string
#   description = "Instance profile name"
#   default     = ""
# }

variable "sg_ssh_inbound_id" {
  type        = string
  description = "SSH Security group ID"
  default     = ""
}

variable "sg_http_inbound_id" {
  type        = string
  description = "HTTP Security group ID"
  default     = ""
}

variable "sg_lb_http_inbound_id" {
  type        = string
  description = "Load balancer HTTP Security group ID"
  default     = ""
}

# variable "ssh_key_name" {
#   type        = string
#   description = "SSH Key name"
#   default     = ""
# }

variable "aws_asg_name" {
  type        = string
  description = "Auto scaling group name"
  default     = ""
}

variable "load_balancer_name" {
  type        = string
  description = "load_balancer name"
  default     = ""
}

variable "public_subnet_id1" {
  description = "Public Subnet id 1"
  type        = string
  default     = ""
}

variable "public_subnet_id2" {
  description = "Public Subnet id 2"
  type        = string
  default     = ""
}

variable "public_subnet_id3" {
  description = "Public Subnet id 3"
  type        = string
  default     = ""
}

variable "vpc_id" {
  type        = string
  description = "VPC id "
  default     = ""
}