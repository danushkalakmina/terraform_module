# resource "mongodbatlas_network_container" "test" {
#   project_id       = var.project_id
#   atlas_cidr_block = "192.168.240.0/21"
#   provider_name    = "AWS"
#   region_name      = "US_EAST_1"
# }

# VPC peering
# Atlas side
resource "mongodbatlas_network_peering" "atlas_network_peering" {
  accepter_region_name   = "us-east-1"
  project_id             = var.ATLAS_PROJECT_ID
  container_id           = var.CONTAINER_ID
  provider_name          = var.ATLAS_PROVIDER
  route_table_cidr_block = var.AWS_VPC_CIDR
  vpc_id                 = var.AWS_VPC_ID
  aws_account_id         = var.AWS_ACCOUNT_ID
}

resource "mongodbatlas_project_ip_access_list" "atlas_ip_access_list_1" {
  project_id = var.ATLAS_PROJECT_ID
  cidr_block = var.AWS_VPC_CIDR
  comment    = "CIDR block for aws to access"
}
# aws side

resource "aws_vpc_peering_connection_accepter" "peer" {
  vpc_peering_connection_id = mongodbatlas_network_peering.atlas_network_peering.connection_id
  auto_accept = true
}

# VPC Peer Device to ATLAS Route Table Association on AWS
data "aws_vpc_peering_connection" "vpc-peering-conn-ds" {
  vpc_id           = mongodbatlas_network_peering.atlas_network_peering.atlas_vpc_name
  cidr_block       = var.ATLAS_VPC_CIDR
  peer_region      = "US_EAST_1"
}

resource "aws_route" "aws_peer_to_atlas_public_route" {
  route_table_id            = var.public_route_id
  destination_cidr_block    = var.ATLAS_VPC_CIDR
  vpc_peering_connection_id = data.aws_vpc_peering_connection.vpc-peering-conn-ds.id
}

resource "aws_route" "aws_peer_to_atlas_private_route_1" {
  route_table_id            = var.private_route_1_id
  destination_cidr_block    = var.ATLAS_VPC_CIDR
  vpc_peering_connection_id = data.aws_vpc_peering_connection.vpc-peering-conn-ds.id
}

resource "aws_route" "aws_peer_to_atlas_private_route_2" {
  route_table_id            = var.private_route_2_id
  destination_cidr_block    = var.ATLAS_VPC_CIDR
  vpc_peering_connection_id = data.aws_vpc_peering_connection.vpc-peering-conn-ds.id
}