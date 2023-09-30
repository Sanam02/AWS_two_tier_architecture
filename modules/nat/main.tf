# Allocate elastic ip this eip used with NAT gateway in the public subnet 1a
resource "aws_eip" "eip-nat-a" {
vpc = true 
tags = {
    Name = "eip-nat-a"
 }
}

# Allocate elastic ip this eip used with NAT gateway in the public subnet 2b
resource "aws_eip" "eip-nat-b" {
    vpc = true
    tags = {
        Name = "eip-nat-b"
    }
}

# Create NAT gateway in public subnet 1a 
resource "aws_nat_gateway" "nat-a" {
    allocation_id = aws_eip.eip-nat-a.id
    subnet_id = var.public_subnet_1a_id
    tags = {
        Name = "nat-a"
    }
}
/*
  # to ensure proper ordering, it is recommended to add an explicit dependency
  depends_on = [var.igw_id]

*/
# create nat gateway in public subnet pub-sub-1-a
resource "aws_nat_gateway" "nat-b" {
  allocation_id = aws_eip.eip-nat-b.id
  subnet_id     = var.public_subnet_2b_id

  tags   = {
    Name = "nat-b"
  }

  # to ensure proper ordering, it is recommended to add an explicit dependency
  # on the internet gateway for the vpc.
  depends_on = [var.igw_id]
}

# create private route table Pri-RT-A and add route through NAT-GW-A
resource "aws_route_table" "pri-rt-a" {
  vpc_id            = var.vpc_id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat-a.id
  }

  tags   = {
    Name = "Pri-rt-a"
  }
}

# associate private subnet pri-sub-3-a with private route table Pri-RT-A
resource "aws_route_table_association" "pri-sub-3a-with-Pri-rt-a" {
  subnet_id         = var.private_subnet_3a_id
  route_table_id    = aws_route_table.pri-rt-a.id
}

# associate private subnet pri-sub-4b with private route table Pri-rt-b
resource "aws_route_table_association" "pri-sub-4b-with-Pri-rt-b" {
  subnet_id         = var.private_subnet_4b_id
  route_table_id    = aws_route_table.pri-rt-a.id
}

# create private route table Pri-rt-b and add route through nat-b
resource "aws_route_table" "pri-rt-b" {
  vpc_id            = var.vpc_id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat-b.id
  }

  tags   = {
    Name = "pri-rt-b"
  }
}

# associate private subnet pri-sub-5a with private route Pri-rt-b
resource "aws_route_table_association" "pri-sub-5a-with-pri-rt-b" {
  subnet_id         = var.private_subnet_5a_id
  route_table_id    = aws_route_table.pri-rt-b.id
}

# associate private subnet pri-sub-6b with private route table Pri-rt-b
resource "aws_route_table_association" "pri-sub-6b-with-pri-rt-b" {
  subnet_id         = var.private_subnet_6b_id
  route_table_id    = aws_route_table.pri-rt-b.id
}
