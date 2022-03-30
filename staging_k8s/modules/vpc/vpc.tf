resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"

  tags = {
    Name = "${var.project}-${var.environment}-Vpc"
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project}-${var.environment}-Igw"
  }
}

resource "aws_subnet" "public_subnet_1" {
  cidr_block              = var.public_subnet_1_block
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = var.public_subnet_1
  map_public_ip_on_launch = true

  tags = {
    Name                                            = "k8sPublicSubnet1"
    Visibility                                      = "Public"
    "kubernetes.io/cluster/${var.k8s_cluster_name}" = "shared"
    "kubernetes.io/role/elb"                        = 1
  }
}

# public subnet #2 for NAT gw
resource "aws_subnet" "public_subnet_2" {
  cidr_block              = var.public_subnet_2_block
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = var.public_subnet_2
  map_public_ip_on_launch = true

  tags = {
    Name                                            = "k8sPublicSubnet2"
    Visibility                                      = "Public"
    "kubernetes.io/cluster/${var.k8s_cluster_name}" = "shared"
    "kubernetes.io/role/elb"                        = 1
  }
}

resource "aws_subnet" "private_subnet_1" {
  cidr_block        = var.private_subnet_1_block
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.private_subnet_1

  tags = {
    Name                                            = "k8sPrivateSubnet1"
    Visibility                                      = "Private"
    "kubernetes.io/cluster/${var.k8s_cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"               = 1
  }
}

# private subnet #2
resource "aws_subnet" "private_subnet_2" {

  cidr_block        = var.private_subnet_2_block
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.private_subnet_2

  tags = {
    Name                                            = "k8sPrivateSubnet2"
    Visibility                                      = "Private"
    "kubernetes.io/cluster/${var.k8s_cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"               = 1
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.project}-${var.environment}-PublicRoute"
  }
}

resource "aws_route_table" "private-route-table_1" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.project}-${var.environment}-PrivateRoute1"
  }

}
resource "aws_route_table" "private-route-table_2" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.project}-${var.environment}-PrivateRoute2"
  }
}
resource "aws_route_table_association" "public-subnet-1-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public_subnet_1.id
}
resource "aws_route_table_association" "public-subnet-2-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public_subnet_2.id
}
resource "aws_route_table_association" "private-subnet-1-association" {
  route_table_id = aws_route_table.private-route-table_1.id
  subnet_id      = aws_subnet.private_subnet_1.id
}

resource "aws_route_table_association" "private-subnet-2-association" {
  route_table_id = aws_route_table.private-route-table_2.id
  subnet_id      = aws_subnet.private_subnet_2.id
}

resource "aws_eip" "elastic-ip-for-nat-gw_1" {
  vpc                       = true
  associate_with_private_ip = var.private_subnet_1_block
  tags = {
    Name = "${var.project}-${var.environment}-NatEip1"
  }
}
# resource "aws_eip" "elastic-ip-for-nat-gw_2" {
#   vpc                       = true
#   associate_with_private_ip = var.private_subnet_2_block
#   tags = {
#     Name = "${var.project}-${var.environment}-NatEip2"
#   }
# }

resource "aws_nat_gateway" "nat-gw_1" {
  allocation_id = aws_eip.elastic-ip-for-nat-gw_1.id
  subnet_id     = aws_subnet.public_subnet_2.id
  tags = {
    Name = "${var.project}-${var.environment}-NatGw1"
  }
}
# resource "aws_nat_gateway" "nat-gw_2" {
#   allocation_id = aws_eip.elastic-ip-for-nat-gw_2.id
#   subnet_id     = aws_subnet.public_subnet_2.id
#   tags = {
#     Name = "${var.project}-${var.environment}-NatGw2"
#   }
# }
resource "aws_route" "nat-gw-route_1" {
  route_table_id         = aws_route_table.private-route-table_1.id
  nat_gateway_id         = aws_nat_gateway.nat-gw_1.id
  destination_cidr_block = "0.0.0.0/0"
}
resource "aws_route" "nat-gw-route_2" {
  route_table_id         = aws_route_table.private-route-table_2.id
  nat_gateway_id         = aws_nat_gateway.nat-gw_1.id
  destination_cidr_block = "0.0.0.0/0"
}

# resource "aws_route" "nat-gw-route_2" {
#   route_table_id         = aws_route_table.private-route-table_2.id
#   nat_gateway_id         = aws_nat_gateway.nat-gw_2.id
#   destination_cidr_block = "0.0.0.0/0"
# }

resource "aws_route" "public-internet-gw-route_1" {
  route_table_id         = aws_route_table.public-route-table.id
  gateway_id             = aws_internet_gateway.gateway.id
  destination_cidr_block = "0.0.0.0/0"
}
