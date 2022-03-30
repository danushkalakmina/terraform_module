resource "aws_security_group" "ElasticCacheRedisClusterSecurityGroup" {
  name        = "${var.Project}-${var.Environment}-ElasticCacheRedisClusterSecurityGroup"
  description = "Allow cache access"
  vpc_id      = var.VpcId
  ingress {
    description      = "TLS from VPC"
    from_port        = 6379
    to_port          = 6379
    protocol         = "tcp"
    cidr_blocks      = var.SecurityGroupIngressCidrBlocks
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
    Name = "${var.Project}-${var.Environment}-ElasticCacheRedisClusterSecurityGroup"
  }

}
