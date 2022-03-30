resource "aws_db_subnet_group" "aws_db_subnet_group" {
  name       = "${var.project}-${var.environment}-db-subnet-group"
  subnet_ids = [var.private_subnet_1, var.private_subnet_2]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_rds_cluster" "tt_aurora_cluster" {
  cluster_identifier      = "${var.project}-${var.environment}-aurora-cluster"
  engine                  = "aurora-mysql"
  engine_version          = var.db_version # "5.7.mysql_aurora.2.10.0"
  availability_zones      = ["us-east-1a", "us-east-1b"]
  database_name           = var.dbname
  master_username         = var.username
  master_password         = var.password
  db_subnet_group_name    = aws_db_subnet_group.aws_db_subnet_group.name
  backup_retention_period = 0
  apply_immediately       = true
  skip_final_snapshot     = true
  #   allocated_storage               = 20
  allow_major_version_upgrade         = false
  vpc_security_group_ids              = [aws_security_group.aurora_sg.id]
  db_cluster_parameter_group_name     = aws_rds_cluster_parameter_group.dev_cluster_parameter_group.name
  iam_database_authentication_enabled = true

  # Here I need to add the IAM role created for RDS to the cluster. But I didn't find a terraform support for this.
  # A simple google gave me below fix. ~ Sadaham
  # Issue is here: https://github.com/hashicorp/terraform/issues/10166

  provisioner "local-exec" {
    command = <<EOF
    aws rds add-role-to-db-cluster \
    --db-cluster-identifier ${var.project}-${var.environment}-aurora-cluster \
    --role-arn ${aws_iam_role.iam_rds_role.arn}
    EOF
  }

  tags = {
    Name = "${var.project}-${var.environment}-aurora-cluster"
  }
}
# Create database instance

resource "aws_rds_cluster_instance" "cluster_instances" {
  count                = 1
  identifier           = "${var.project}-${var.environment}-aurora-instance-${count.index}"
  cluster_identifier   = aws_rds_cluster.tt_aurora_cluster.id
  instance_class       = var.instance_class
  engine               = aws_rds_cluster.tt_aurora_cluster.engine
  engine_version       = aws_rds_cluster.tt_aurora_cluster.engine_version
  publicly_accessible  = false
  db_subnet_group_name = aws_db_subnet_group.aws_db_subnet_group.name
  apply_immediately    = true

  tags = {
    Name = "${var.project}-${var.environment}-aurora-instance-${count.index}"
  }

}
