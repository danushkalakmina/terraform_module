resource "aws_elasticache_parameter_group" "Redis6xParameterGroup" {
  name   = "${var.Project}-RedisParameterGroup"
  family = "redis6.x"

  parameter {
    name  = "notify-keyspace-events"
    value = "KEg$lshzxeA"
  }
}