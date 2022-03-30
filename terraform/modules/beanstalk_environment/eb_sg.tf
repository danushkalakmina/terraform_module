# https://github.com/aws/elastic-beanstalk-roadmap/issues/44
resource "aws_security_group" "eb_environment_sg" {
  name        = "${var.project}-${var.environment}-${var.service_name}-sg"
  description = "${var.project}-${var.environment}-${var.service_name}-sg"
  vpc_id      = var.vpcid

  ingress {
    description = "http from alb"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Environment = var.environment
    project     = var.project
    Name        = "${var.project}-${var.environment}-${var.service_name}-sg"
  }

}