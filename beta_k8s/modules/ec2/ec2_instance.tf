resource "aws_instance" "BastionInstance" {
  ami                         = "ami-0533f2ba8a1995cf9"
  instance_type               = "t2.nano"
  subnet_id                   = var.ec2SubnetId
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id]
  key_name                    = "TrenderTag-k8s-BETA"
  associate_public_ip_address = true

  tags = {
    Name = "${var.project}-${var.environment}-BastionInstance"
  }
}