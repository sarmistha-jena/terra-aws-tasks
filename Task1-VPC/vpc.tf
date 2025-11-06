resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "example_subnets" {
  for_each = var.subnets

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    Name = each.value.name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "cmtr-959pompn-01-igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "cmtr-959pompn-01-rt"
  }
}

resource "aws_route_table_association" "public_rta_1" {
  for_each  = var.subnets
  subnet_id = aws_subnet.example_subnets[each.key].id
  #   subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public_rt.id
}
