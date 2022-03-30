resource "aws_mq_broker" "TrenderRabbitMqBroker" {
  broker_name = "${var.Project}-${var.Environment}-RabbitMqBroker"

  engine_type                = "RabbitMQ"
  engine_version             = "3.8.22"
  storage_type               = "ebs"
  host_instance_type         = "mq.m5.large"
  deployment_mode            = "CLUSTER_MULTI_AZ"
  security_groups            = [aws_security_group.MqSecurityGroup.id]
  publicly_accessible        = false
  auto_minor_version_upgrade = false
  subnet_ids                 = var.PrivateSubnets

  maintenance_window_start_time {
    day_of_week = "SUNDAY"
    time_of_day = "02:00"
    time_zone   = "America/Los_Angeles"
  }

  user {
    username = var.MqUsername
    password = random_password.RandomMqPassword.result
  }

  logs {
    general = true
  }
}
