variable "project_id" {
  type        = string
  description = "Project id used for billing"
  default     = "cmtr-959pompn"
}

variable "vpc_cidr" {
  type        = string
  description = "The IP range to use for the VPC"
  default     = "10.10.0.0/16"
}

variable "vpc_name" {
  type        = string
  description = "The name to use for the VPC"
  default     = "cmtr-959pompn-01-vpc"
}

variable "subnets" {
  description = "The name, cidr, availability zones to use for the subnets"
  type = map(object({
    name              = string
    availability_zone = string
    cidr_block        = string
  }))
  default = {
    public_subnet_1 = {
      name              = "cmtr-959pompn-01-subnet-public-a"
      availability_zone = "us-east-1a"
      cidr_block        = "10.10.1.0/24"
    }
    public_subnet_2 = {
      name              = "cmtr-959pompn-01-subnet-public-b"
      availability_zone = "us-east-1b"
      cidr_block        = "10.10.3.0/24"
    }
    public_subnet_3 = {
      name              = "cmtr-959pompn-01-subnet-public-c"
      availability_zone = "us-east-1c"
      cidr_block        = "10.10.5.0/24"
    }
  }
}

variable "ssh_key" {
  description = "Provides custom public SSH key."
  default     = ""
  type        = string
}

####################################
# IAM Variables with Type & Description
####################################

variable "iam_group_name" {
  description = "The name of the IAM group to be created."
  type        = string
  default     = "cmtr-959pompn-iam-group"
}

variable "iam_policy_name" {
  description = "The name of the custom IAM policy that grants S3 write permissions."
  type        = string
  default     = "cmtr-959pompn-iam-policy"
}

variable "iam_role_name" {
  description = "The name of the IAM role to be assumed by EC2 instances."
  type        = string
  default     = "cmtr-959pompn-iam-role"
}

variable "iam_instance_profile_name" {
  description = "The name of the IAM instance profile to associate with the EC2 role."
  type        = string
  default     = "cmtr-959pompn-iam-instance-profile"
}

variable "bucket_name" {
  description = "The name of the S3 bucket to which the IAM policy grants write access."
  type        = string
  default     = "cmtr-959pompn-bucket-1762758358"
}

####################################
# SG Variables with Type & Description
####################################

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

variable "private_subnet_name" {
  description = "Private Subnet name"
  type        = string
  default     = ""
}

variable "public_subnet_name" {
  description = "Public Subnet name"
  type        = string
  default     = ""
}

variable "public_instance_id" {
  description = "Public Instance Id"
  type        = string
  default     = ""
}

variable "private_instance_id" {
  description = "Private Instance Id"
  type        = string
  default     = ""
}