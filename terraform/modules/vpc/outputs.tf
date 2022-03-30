output "VpcId" {
  value = aws_vpc.Vpc.id
}

output "PublicSubnet1" {
  value       = aws_subnet.PublicSubnet1.id
}

output "PublicSubnet2" {
  value       = aws_subnet.PublicSubnet2.id
}

output "PrivateSubnet1" {
  value       = aws_subnet.PrivateSubnet1.id
}

output "PrivateSubnet2" {
  value       = aws_subnet.PrivateSubnet2.id
}

output "CidrBlock" {
  value = aws_vpc.Vpc.cidr_block
}

# VPC - route tables (for mongodb peering)
output PublicRouteTableId {
  value = aws_route_table.PublicRouteTable.id
}

output PrivateRouteTable1_Id {
  value = aws_route_table.PrivateRouteTable1.id
}

output PrivateRouteTable2_Id {
  value = aws_route_table.PrivateRouteTable2.id
}