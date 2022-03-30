resource "aws_elasticache_subnet_group" "ElasticCacheRedisClusterSubnetGroup" {
  name       = "${var.Project}-${var.Environment}-ElasticCacheRedisClusterSubnetGroup"
#   subnet_ids = [var.PrivateSubnet1, var.PrivateSubnet2]
subnet_ids = var.PrivateSubnets
}
