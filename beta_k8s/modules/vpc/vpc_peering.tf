# # example
# # https://www.nicksantamaria.net/post/how-to-peer-vpcs-with-terraform/

# # Discover the Shared VPC ID using Tags
# data "aws_vpc" "beta_vpc" {
#   filter {
#     name   = "tag:Name"
#     values = ["TT-PROD-Beta-VPC"]
#   }
# }

# # Create peering conenction with Shared VPC

# resource "aws_vpc_peering_connection" "peer_connection" {
#   peer_owner_id = var.account_number
#   peer_vpc_id   = data.aws_vpc.beta_vpc.id
#   vpc_id        = aws_vpc.vpc.id
#   auto_accept   = true

#   tags = {
#     Name = "Beta-VPC-Peering"
#   }
# }

# #  aws_route on shared vpc main route table.

# resource "aws_route" "betaVpcMainRouteTable" {
#   # ID of VPC 1 main route table.
#   route_table_id = "${aws_vpc.primary.main_route_table_id}"
#   # CIDR block / IP range for VPC 2.
#   destination_cidr_block = "${aws_vpc.secondary.cidr_block}"
#   # ID of VPC peering connection.
#   vpc_peering_connection_id = "${aws_vpc_peering_connection.primary2secondary.id}"
# }

# # #  aws_route on shared vpc main route table.

# # resource "aws_route" "mainVpcMainRouteTable" {
# #   # ID of VPC 1 main route table.
# #   route_table_id = "${aws_vpc.primary.main_route_table_id}"

# #   # CIDR block / IP range for VPC 2.
# #   destination_cidr_block = "${aws_vpc.secondary.cidr_block}"

# #   # ID of VPC peering connection.
# #   vpc_peering_connection_id = "${aws_vpc_peering_connection.primary2secondary.id}"
# # }