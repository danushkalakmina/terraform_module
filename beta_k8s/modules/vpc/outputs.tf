output "vpcid" {
  value = aws_vpc.vpc.id
}

output "public_subnet_1" {
  description = "ID of Public subnet 1"
  value       = aws_subnet.public_subnet_1.id
}

output "public_subnet_2" {
  description = "ID of Public subnet 2"
  value       = aws_subnet.public_subnet_2.id
}

output "private_subnet_1" {
  description = "ID of Private subnet 1"
  value       = aws_subnet.private_subnet_1.id
}

output "private_subnet_2" {
  description = "ID of Private subnet 2"
  value       = aws_subnet.private_subnet_2.id
}

output "cidr_block" {
  value = aws_vpc.vpc.cidr_block
}

# VPC - route tables (for mongodb peering)
output public_route_id {
  value = aws_route_table.public-route-table.id
}

output private_route_1_id {
  value = aws_route_table.private-route-table_1.id
}

output private_route_2_id {
  value = aws_route_table.private-route-table_2.id
}