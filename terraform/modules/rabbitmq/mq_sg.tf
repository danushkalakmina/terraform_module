resource "aws_security_group" "MqSecurityGroup" {
  name        = "${var.Project}-${var.Environment}-MqSecurityGroup"
  description = "The security group of AmazonMq"
  vpc_id      = var.VpcId

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
    Name        = "${var.Project}-${var.Environment}-MqSecurityGroup"
  }

}

resource "aws_security_group_rule" "EnableMqPortWithinVpc" {
  type              = "ingress"
  from_port         = 5671
  to_port           = 5671
  protocol          = "tcp"
  cidr_blocks       = [var.VpcCidr]
  security_group_id = aws_security_group.MqSecurityGroup.id
}

resource "aws_security_group_rule" "EnableHttpsPortWithinVpc" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = [var.VpcCidr]
  security_group_id = aws_security_group.MqSecurityGroup.id
}