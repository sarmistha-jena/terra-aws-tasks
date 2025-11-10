resource "aws_instance" "server" {
  ami           = "ami-0ecb62995f68bb549" # Replace with a valid AMI ID
  instance_type = "t2.micro"
  #key_name               = aws_key_pair.cmtr-959pompn-keypair.key_name
  vpc_security_group_ids = [data.terraform_remote_state.base_infra.outputs.security_group_id]
  subnet_id              = data.terraform_remote_state.base_infra.outputs.public_subnet_id
  tags = {
    Terraform = true
    Project   = var.project_id
  }
}