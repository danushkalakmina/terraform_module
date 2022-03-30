output "iam_instance_profile" {
  description = "instance profile name to use with beanstalk environment"
  value       = aws_iam_instance_profile.beanstalk_ec2_instance_profile.name
}