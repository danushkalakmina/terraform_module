output "AlbArn" {
  description = "arn of the alb"
  value       = aws_lb.AlbPublic.arn
}

output "ZoneId" {
  description = "route 53 zone if of the alb"
  value       = aws_lb.AlbPublic.zone_id
}

output "DnsName" {
  description = "dns name of the alb"
  value       = aws_lb.AlbPublic.dns_name
}