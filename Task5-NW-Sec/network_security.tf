resource "aws_security_group" "ssh_sg" {
  name        = var.ssh_security_group_name
  description = "Allow SSH and ICMP from allowed IPs"
  vpc_id      = data.aws_vpc.selected_vpc.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ip_range
  }

  ingress {
    description = "Allow ICMP (ping)"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = var.allowed_ip_range
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Project = var.project_id
  }
}

resource "aws_security_group" "public_http_sg" {
  name        = var.public_http_security_group_name
  description = "Allow HTTP and ICMP from allowed IPs"
  vpc_id      = data.aws_vpc.selected_vpc.id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.allowed_ip_range
  }

  ingress {
    description = "Allow ICMP (ping)"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = var.allowed_ip_range
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Project = var.project_id
  }
}

resource "aws_security_group" "private_http_sg" {
  name        = var.private_http_security_group_name
  description = "Allow HTTP (8080) and ICMP from allowed IPs"
  vpc_id      = data.aws_vpc.selected_vpc.id

  tags = {
    Project = var.project_id
  }
}

resource "aws_security_group_rule" "allow_http_private" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.public_http_sg.id
  security_group_id        = aws_security_group.private_http_sg.id
  description              = "Allow public servers to connect to the private"
}

resource "aws_security_group_rule" "allow_icmp_private" {
  type                     = "ingress"
  from_port                = -1
  to_port                  = -1
  protocol                 = "icmp"
  source_security_group_id = aws_security_group.public_http_sg.id
  security_group_id        = aws_security_group.private_http_sg.id
  description              = "Allow public servers to connect to the private"
}

resource "aws_network_interface_sg_attachment" "private_ssh_sg_attachment" {
  network_interface_id = data.aws_instance.private_instance.network_interface_id
  security_group_id    = aws_security_group.ssh_sg.id
}

resource "aws_network_interface_sg_attachment" "private_http_sg_attachment" {
  network_interface_id = data.aws_instance.private_instance.network_interface_id
  security_group_id    = aws_security_group.private_http_sg.id
}

resource "aws_network_interface_sg_attachment" "public_ssh_sg_attachment" {
  network_interface_id = data.aws_instance.public_instance.network_interface_id
  security_group_id    = aws_security_group.ssh_sg.id
}

resource "aws_network_interface_sg_attachment" "public_http_sg_attachment" {
  network_interface_id = data.aws_instance.public_instance.network_interface_id
  security_group_id    = aws_security_group.public_http_sg.id
}