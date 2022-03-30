data "aws_route53_zone" "trendertag" {
  name         = var.domain_name
  private_zone = false
}

# url to access internal alb
resource "aws_route53_record" "api_alb" {
  zone_id = data.aws_route53_zone.trendertag.zone_id
  name    = "${var.service_name}.${data.aws_route53_zone.trendertag.name}"
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}