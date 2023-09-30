# CREATING VPC 
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.project_name}-vpc"
  }

}
#CREATING INTERNET GATEWAY
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}
#using data source to get all avaliablity zones in region
data "aws_availability_zones" "available_zones" {}

# CREATING PUBLIC SUBNET PUBLIC_SUBNET_1A
resource "aws_subnet" "public_subnet_1a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_1a
  availability_zone       = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "Public_Subnet_1a"
  }
}

# CREATING_PUBLIC_SUBNET_2B
resource "aws_subnet" "public_subnet_2b" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.public_subnet_2b
  availability_zone = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch = true
  tags = {
    Names = "Public_Subnet_2b"
  }
}

# CREATE ROUTE TABLE AND ADD PUBLIC ROUTE 
resource "aws_route_table" "public_route_table" {
vpc_id = aws_vpc.vpc.id
route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
}
tags = {
    Name = "Public-rt"
}
}

# ASSOCIATE PUBLIC SUBNET PUBLIC_SUBNET_1A TO PUBLIC ROUTE TABLE
resource "aws_route_table_association" "public_subnet_1a_route_assn" {
    subnet_id = aws_subnet.public_subnet_1a.id
    route_table_id = aws_route_table.public_route_table.id
}

# ASSOCIATE PUBLIC_SUBNET_2B TO PUBLIC ROUTE TABLE
resource "aws_route_table_association" "public_subnet_2b_route_assn" {
    subnet_id = aws_subnet.public_subnet_2b.id
    route_table_id = aws_route_table.public_route_table.id 
}
# CREATING_PRIVATE_SUBNET_3A
resource "aws_subnet" "private_subnet_3a" {
vpc_id = aws_vpc.vpc.id
cidr_block = var.private_subnet_3a
availability_zone = data.aws_availability_zones.available_zones.names[0]
map_public_ip_on_launch = false
tags = {
    Name = "Private_subnet_3a"
}
}

# Creating Private_subnet_4B
resource "aws_subnet" "private_subnet_4b" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_subnet_4b
    availability_zone = data.aws_availability_zones.available_zones.names[1]
    tags = {
        Names = "private_subnet_4b"
    }
}

# Creating Private_subnet_5A
resource "aws_subnet" "private_subnet_5a" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_subnet_5a
    availability_zone = data.aws_availability_zones.available_zones.names[0]
    map_public_ip_on_launch = false
    tags = {
        Names = "private_subnet_5a"
    }
}

# Creating Private_subnet_6B
resource "aws_subnet" "private_subnet_6b" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_subnet_6b
    availability_zone = data.aws_availability_zones.available_zones.names[1]
    map_public_ip_on_launch = false
    tags = {
        Names = "private_subnet_6b"
    }
}
