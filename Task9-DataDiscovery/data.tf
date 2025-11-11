# Configure AWS data sources for resource discovery:
# aws_vpc - discover VPC by name tag
# aws_subnet - discover public subnet by name tag
# aws_security_group - discover security group by name tag
# aws_ami - get latest Amazon Linux 2023 AMI
# Use filters and tags to find existing resources

data "aws_vpc" "selected_vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnet" "selected_subnet" {
  filter {
    name   = "tag:Name"
    values = [var.public_subnet_name]
  }
}

output "vpc_id" {
  value = data.aws_vpc.selected_vpc.id
}

data "aws_security_group" "sg" {
  name = var.security_group_name
}
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"] # Official AWS AMIs are owned by 'amazon'

  #   filter {
  #     name   = "name"
  #     values = ["al2023-ami-*"] # Filters for AMIs with names starting with 'al2023-ami-'
  #   }

  filter {
    name   = "architecture"
    values = ["x86_64"] # Or "arm64" for Graviton instances
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"] # Amazon Linux 2023 uses HVM virtualization
  }
}

output "latest_amazon_linux_2023_ami_id" {
  value = data.aws_ami.amazon_linux_2023.id
}