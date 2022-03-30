output "sg_id" {
  description = "the security group id of the ec2 instance"
  value = aws_security_group.allow_ssh.id
}