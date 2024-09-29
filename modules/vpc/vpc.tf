# Create a VPC resource
resource "aws_vpc" "demo-vpc" {
  cidr_block           = var.aws_vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = {
    Name = "demo vpc"
  }
}

# Create public subnets within the VPC
resource "aws_subnet" "public-subnet" {
  vpc_id = aws_vpc.demo-vpc
  count  = length(var.public_subnet_cidr)

  cidr_block        = element(var.public_subnet_cidr, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "public subnet ${count.index + 1}"
  }
}

# Create private subnets within the VPC
resource "aws_subnet" "private-subnet" {
  vpc_id = aws_vpc.demo-vpc
  count  = length(var.private_subnet_cidr)

  cidr_block        = element(var.private_subnet_cidr, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "private subnet ${count.index + 1}"
  }
}

# Create an internet gateway for the VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.demo-vpc

  tags = {
    Name = "vpc igw"
  }
}

# Create a public route table and associate it with the VPC
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.demo-vpc

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# Associate public subnets with the public route table
resource "aws_route_table_association" "public-subnet-association" {
  count          = length(var.public_subnet_cidr)
  subnet_id      = aws_subnet.public-subnet[count.index].id
  route_table_id = aws_route_table.public-route-table.id
}