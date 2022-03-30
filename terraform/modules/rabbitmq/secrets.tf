resource "random_password" "RandomMqPassword" {
  length  = 15
  special = false
}

resource "aws_secretsmanager_secret" "SecretMqPassword" {
  name = "${var.Project}-${var.Environmnet}-SecretMqPassword"
}

resource "aws_secretsmanager_secret_version" "MqPassword" {
  secret_id     = aws_secretsmanager_secret.SecretMqPassword.id
  secret_string = <<EOF
                  {
                    "username": "${var.MqUsername}",
                    "password": "${random_password.RandomMqPassword.result}",
                  }
                  EOF
}
