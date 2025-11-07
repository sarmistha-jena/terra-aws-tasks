resource "aws_instance" "web_server" {
  ami                    = "ami-0ecb62995f68bb549" # Replace with a valid AMI ID
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.cmtr-959pompn-keypair.key_name
  vpc_security_group_ids = [data.aws_security_group.my_sg.id]
  subnet_id              = data.aws_subnets.selected_subnets.ids[0]
  tags = {
    Name    = "cmtr-959pompn-ec2"
    Project = "epam-tf-lab"
    ID      = "cmtr-959pompn"
  }
}

data "aws_vpc" "selected_vpc" {
  # tags = {
  #   Name = "MyExistingVPC" # Replace with the actual tag for your VPC
  # }
  # Alternatively, if you want to find the default VPC:
  # default = true
}

output "vpc_id" {
  value = data.aws_vpc.selected_vpc.id
}

data "aws_subnets" "selected_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected_vpc.id]
  }
}

data "aws_security_group" "my_sg" {
  filter {
    name   = "group-name"
    values = ["cmtr-959pompn-sg"]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected_vpc.id]
  }
}
