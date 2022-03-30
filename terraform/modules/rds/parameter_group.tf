resource "aws_rds_cluster_parameter_group" "dev_cluster_parameter_group" {
  name        = "${var.project}-${var.environment}-rds-cluster-pg"
  family      = "aurora-mysql5.7"
  description = "RDS cluster parameter group for ${var.environment}"

  parameter {
    name  = "aws_default_lambda_role"
    value = aws_iam_role.iam_rds_role.arn
  }

}