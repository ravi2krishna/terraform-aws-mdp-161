# VPC 
resource "aws_vpc" "lms" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "lms"
  }
}

# Subnet
resource "aws_subnet" "lms-subnet" {
  vpc_id                  = aws_vpc.lms.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "lms-subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "lms-igw" {
  vpc_id = aws_vpc.lms.id

  tags = {
    Name = "lms-igw"
  }
}

# Route Table
resource "aws_route_table" "lms-rt" {
  vpc_id = aws_vpc.lms.id
  tags = {
    Name = "lms-rt"
  }
}

# Route for internet
resource "aws_route" "lms-igw-route" {
  route_table_id         = aws_route_table.lms-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.lms-igw.id
}

# Route Table - Subnet Association
resource "aws_route_table_association" "lms-rt-sn" {
  subnet_id      = aws_subnet.lms-subnet.id
  route_table_id = aws_route_table.lms-rt.id
}