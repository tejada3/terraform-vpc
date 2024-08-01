#VPC
resource "aws_vpc" "jt_vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    "Name" = "jt_vpc"
  }

}
# 2 subnets
resource "aws_subnet" "main" {
  count = length(var.subnet_cidr)
  vpc_id     = aws_vpc.jt_vpc.id
  cidr_block = var.subnet_cidr[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet_names[count.index]
  }
}

#internet gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.jt_vpc.id

  tags = {
    Name = "jt-InternetGateway"
  }
}

#route table

resource "aws_route_table" "jt_rt" {
  vpc_id = aws_vpc.jt_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }


  tags = {
    Name = "jt-rt"
  }
}

#Route table association
resource "aws_route_table_association" "rta" {
  count = length(var.subnet_cidr)
  subnet_id      = aws_subnet.main[count.index].id
  route_table_id = aws_route_table.jt_rt.id
}