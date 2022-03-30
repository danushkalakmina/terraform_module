resource "aws_security_group" "AlbPublicSecurityGroup" {
  name        = "${var.Project}-${var.Environment}-AlbPublicSecurityGroup"
  description = "Used in ${var.Environment}"
  vpc_id      = var.VpcId

  ingress {
    description = "Enable HTTPS traffic from internet"
    from_port   = 443
    to_port     = 443
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
    Environment = var.Environment
    Project     = var.Project
    Name        = "${var.Project}-${var.Environment}-AlbPublicSecurityGroup"
  }

}