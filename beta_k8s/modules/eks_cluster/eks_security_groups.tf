# resource "aws_security_group" "allow_tls" {
#   name        = "${var.cluster_name}-AdditionalSecurityGroup"
#   description = "Allow 443 from bastion host"
#   vpc_id      = var.vpcId

#   ingress {
#     description = "TLS from VPC"
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     # security_groups = [var.security_groups]
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   tags = {
#     Name = "${var.cluster_name}-AdditionalSecurityGroup"
#   }
# }
