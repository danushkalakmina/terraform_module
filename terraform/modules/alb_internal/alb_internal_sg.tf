resource "aws_security_group" "AlbInternalSecurityGroup" {
  name        = "${var.Project}-${var.Environment}-InternalAlbSecurityGroup"
  description = "Used in ${var.Environment}"
  vpc_id      = var.VpcId

  ingress {
    description = "Enable HTTP traffic within the VPC"
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
    Environment = var.Environment
    project     = var.Project
    Name        = "${var.Project}-${var.Environment}-InternalAlbSecurityGroup"
  }

}