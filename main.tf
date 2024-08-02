resource "aws_vpc" "EffulgenceVpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = var.instance_tenancy

      tags = merge(
       var.tags,
    {
      Name = "EffulgenceVpc"
    },
  )
}

resource "aws_internet_gateway" "EffulgenceVpcIGW" {
  vpc_id = aws_vpc.EffulgenceVpc.id

      tags = merge(
       var.tags,
    {
      Name = "EffulgenceVpcIGW"
    },
  )
}

resource "aws_subnet" "EffulgenceVpcPublicSubnet" {
  vpc_id     = aws_vpc.EffulgenceVpc.id
  cidr_block = var.pub_subnet_cidr_block

      tags = merge(
       var.tags,
    {
      Name = "EffulgenceVpcPublicSubnet"
    },
  )
}

resource "aws_subnet" "EffulgenceVpcPrivateSubnet" {
  vpc_id     = aws_vpc.EffulgenceVpc.id
  cidr_block = var.priv_subnet_cidr_block

      tags = merge(
       var.tags,
    {
      Name = "EffulgenceVpcPrivateSubnet"
    },
  )
}

resource "aws_route_table" "PublicRT" {
  vpc_id = aws_vpc.EffulgenceVpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.EffulgenceVpcIGW.id
  }

      tags = merge(
       var.tags,
    {
      Name = "PublicRT"
    },
  )
}

resource "aws_route_table_association" "PublicRTAssociation" {
  subnet_id      = aws_subnet.EffulgenceVpcPublicSubnet.id
  route_table_id = aws_route_table.PublicRT.id
}

resource "aws_eip" "NATEIP" {
}

resource "aws_nat_gateway" "EffulgenceVpcNATGW" {
  allocation_id = aws_eip.NATEIP.id
  subnet_id     = aws_subnet.EffulgenceVpcPublicSubnet.id

     tags = merge(
      var.tags,
    {
      Name = "EffulgenceVpcNATGW"
    },
  )

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.EffulgenceVpcIGW]
}

resource "aws_route_table" "PrivateRT" {
  vpc_id = aws_vpc.EffulgenceVpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.EffulgenceVpcNATGW.id
  }

      tags = merge(
      var.tags,
    {
      Name = "PrivateRT"
    },
  )
}

resource "aws_route_table_association" "PrivateRTAssociation" {
  subnet_id      = aws_subnet.EffulgenceVpcPrivateSubnet.id
  route_table_id = aws_route_table.PrivateRT.id
}
