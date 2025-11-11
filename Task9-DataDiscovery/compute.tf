resource "aws_instance" "ec2" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_security_group.sg.id]
  subnet_id              = data.aws_subnet.selected_subnet.id
  tags = {
    Name    = "cmtr-959pompn-instance"
    Project = var.project_id
  }
}