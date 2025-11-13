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
      name              = "cmtr-959pompn-subnet-public-a"
      availability_zone = "us-east-1a"
      cidr_block        = "10.10.1.0/24"
    }
    public_subnet_2 = {
      name              = "cmtr-959pompn-subnet-public-b"
      availability_zone = "us-east-1b"
      cidr_block        = "10.10.3.0/24"
    }
    public_subnet_3 = {
      name              = "cmtr-959pompn-subnet-public-c"
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
