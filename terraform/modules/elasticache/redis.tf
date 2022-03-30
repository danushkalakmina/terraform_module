resource "aws_elasticache_replication_group" "RedisReplicationGroup" {
  
  automatic_failover_enabled  = true
  multi_az_enabled            = true
  preferred_cache_cluster_azs = var.Azs
  replication_group_id        = "${var.Project}-${var.Environment}-RedisReplicationGroup"
  description                 = "RedisReplicationGroup"
  node_type                   = var.NodeType
  engine_version              = "6.x"
  num_cache_clusters          = 2
  parameter_group_name        = aws_elasticache_parameter_group.Redis6xParameterGroup.name
  port                        = 6379
  maintenance_window          = var.MaintenanceWindow
  snapshot_window             = var.SnapshotWindow
  security_group_ids          = [aws_security_group.ElasticCacheRedisClusterSecurityGroup.id]
  subnet_group_name           = aws_elasticache_subnet_group.ElasticCacheRedisClusterSubnetGroup.name
  snapshot_retention_limit    = 7

  # provisioner "local-exec" {
  #   command = "open WFH, '>completed.txt' and print WFH scalar localtime"
  #   interpreter = ["perl", "-e"]
  # }

  lifecycle {
    ignore_changes = [num_cache_clusters]
  }
}

# resource "aws_elasticache_cluster" "replica" {
#   count = 1

#   cluster_id           = "redis-replication-group-${count.index}"
#   replication_group_id = aws_elasticache_replication_group.RedisReplicationGroup.id
# }
