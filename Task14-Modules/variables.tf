variable "project_id" {
  type        = string
  description = "Project identifier for tagging"
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

variable "igw_name" {
  type        = string
  description = "The name to use for the Internet gateway"
  default     = ""
}

variable "rt_name" {
  type        = string
  description = "The name to use for the Route Table"
  default     = ""
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

###############################################
# Data Source Variables with Type & Description
###############################################

variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = ""
}

variable "state_bucket" {
  description = "S3 bucket name for remote state"
  type        = string
  default     = ""
}

variable "state_key" {
  description = "S3 key path for remote state file"
  type        = string
  default     = ""
}

###############################################
# Application Load Balancer Variables with Type & Description
###############################################

variable "aws_launch_template_name" {
  type        = string
  description = "Launch template name"
  default     = ""
}

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

variable "ssh_key_name" {
  type        = string
  description = "SSH Key name"
  default     = ""
}

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

# Traffic Weight for Blue and Green Target Groups  
variable "blue_weight" {
  description = "The traffic weight for the Blue Target Group. Specifies the percentage of traffic routed to the Blue environment."
  type        = number
  default     = 100
}

variable "green_weight" {
  description = "The traffic weight for the Green Target Group. Specifies the percentage of traffic routed to the Green environment."
  type        = number
  default     = 0
}

variable "blue_aws_launch_template_name" {
  type        = string
  description = "Blue Launch template name"
  default     = ""
}

variable "green_aws_launch_template_name" {
  type        = string
  description = "Blue Launch template name"
  default     = ""
}

variable "blue_asg_name" {
  type        = string
  description = "Blue Auto scaling group name"
  default     = ""
}

variable "green_asg_name" {
  type        = string
  description = "Green Auto scaling group name"
  default     = ""
}

variable "public_subnet_name_1" {
  description = "Public Subnet name 1"
  type        = string
  default     = ""
}

variable "public_subnet_name_2" {
  description = "Public Subnet name 2"
  type        = string
  default     = ""
}

variable "blue_tg_name" {
  description = "Blue target group name"
  type        = string
  default     = ""
}

variable "green_tg_name" {
  description = "Green target group name"
  type        = string
  default     = ""
}