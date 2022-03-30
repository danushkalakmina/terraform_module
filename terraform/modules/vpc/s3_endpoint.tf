# resource "aws_vpc_endpoint" "S3_EndPoint" {
#   vpc_id       = aws_vpc.Vpc.id
#   service_name = "com.amazonaws.us-east-1.s3"
# }

# resource "aws_vpc_endpoint_route_table_association" "PublicRouteTableAssociation" {
#   route_table_id  = aws_route_table.PublicRouteTable.id
#   vpc_endpoint_id = aws_vpc_endpoint.S3_EndPoint.id
# }

# resource "aws_vpc_endpoint_route_table_association" "PrivateRouteTable1_Association" {
#   route_table_id  = aws_route_table.PrivateRouteTable1.id
#   vpc_endpoint_id = aws_vpc_endpoint.S3_EndPoint.id
# }

# resource "aws_vpc_endpoint_route_table_association" "PrivateRouteTable2_Association" {
#   route_table_id  = aws_route_table.PrivateRouteTable2.id
#   vpc_endpoint_id = aws_vpc_endpoint.S3_EndPoint.id
# }