
resource "aws_security_group" "aurora_sg" {
  name        = "${var.project}-${var.environment}-aurora-sg"
  description = "Allow db access"
  vpc_id = var.vpcid
  ingress {
    description      = "TLS from VPC"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
    tags = {
    Name = "${var.environment}_aurora_sg"
  }

}