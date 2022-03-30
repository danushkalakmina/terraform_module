data "aws_route53_zone" "domain_name" {
  name         = "${var.domain_name}"
  private_zone = false
}

resource "aws_route53_record" "cf_cname" {
  zone_id = data.aws_route53_zone.domain_name.zone_id
  name    = "${var.environment}.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.www_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.www_distribution.hosted_zone_id
    evaluate_target_health = true
  }
}