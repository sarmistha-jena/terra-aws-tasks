data "aws_vpc" "selected_vpc" {
  cidr_block = "10.0.0.0/16"
}

output "vpc_id" {
  value = data.aws_vpc.selected_vpc.id
}

# data "aws_subnets" "selected_public_subnets" {
#   #   filter {
#   #     name   = "vpc-id"
#   #     values = [data.aws_vpc.selected_vpc.id]
#   #   }
#   filter {
#     name   = "tag:Name"
#     values = [var.public_subnet_name]
#   }
# }

# data "aws_subnets" "selected_private_subnets" {
#   filter {
#     name   = "tag:Name"
#     values = [var.private_subnet_name]
#   }
# }

# data "aws_network_interface" "public_eni_in_subnet" {
#   filter {
#     name   = "subnet-id"
#     values = [data.aws_subnets.selected_public_subnets.id] # Replace aws_subnet.example.id with the actual subnet ID or reference
#   }
# }

# data "aws_network_interface" "private_eni_in_subnet" {
#   filter {
#     name   = "subnet-id"
#     values = [data.aws_subnets.selected_private_subnets.id] # Replace aws_subnet.example.id with the actual subnet ID or reference
#   }
# }

data "aws_instance" "public_instance" {
  instance_id = var.public_instance_id
}

data "aws_instance" "private_instance" {
  instance_id = var.private_instance_id
}