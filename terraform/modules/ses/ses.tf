# Domain verification

resource "aws_ses_domain_identity" "domain" {
  domain = var.domain_name
}

resource "aws_route53_record" "domain_amazonses_verification_record" {
  zone_id = var.zone_id
  name    = "_amazonses.${var.domain_name}"
  type    = "TXT"
  ttl     = "600"
  records = [aws_ses_domain_identity.domain.verification_token]
}

# DKIM verification

resource "aws_ses_domain_dkim" "domain_dkim" {
  domain = aws_ses_domain_identity.domain.domain
}

resource "aws_route53_record" "example_amazonses_dkim_record" {
  count   = 3
  zone_id = var.zone_id
  name    = "${element(aws_ses_domain_dkim.domain_dkim.dkim_tokens, count.index)}._domainkey"
  type    = "CNAME"
  ttl     = "600"
  records = ["${element(aws_ses_domain_dkim.domain_dkim.dkim_tokens, count.index)}.dkim.amazonses.com"]
}

# custom mail from domain

resource "aws_ses_domain_mail_from" "mail_from_domain" {
  domain           = aws_ses_domain_identity.domain.domain
  mail_from_domain = "mail.${aws_ses_domain_identity.domain.domain}"
}

# Route53 MX record
resource "aws_route53_record" "ses_domain_mail_from_mx" {
  zone_id = var.zone_id
  name    = aws_ses_domain_mail_from.mail_from_domain.mail_from_domain
  type    = "MX"
  ttl     = "600"
  records = ["10 feedback-smtp.${var.aws_region}.amazonses.com"] # Change to the region in which `aws_ses_domain_identity.example` is created
}

# Route53 TXT record for SPF
resource "aws_route53_record" "ses_domain_mail_from_txt" {
  zone_id = var.zone_id
  name    = aws_ses_domain_mail_from.mail_from_domain.mail_from_domain
  type    = "TXT"
  ttl     = "600"
  records = ["v=spf1 include:amazonses.com -all"]
}

# sns topic to send bouce notifications
resource "aws_sns_topic" "ses_updates" {
  name = "${var.Project}-ses-bounce-topic"
}

resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn = aws_sns_topic.ses_updates.arn
  protocol  = "email"
  endpoint  = var.sns_email
}

resource "aws_ses_identity_notification_topic" "ses_notification" {
  topic_arn                = aws_sns_topic.ses_updates.arn
  notification_type        = "Bounce"
  identity                 = aws_ses_domain_identity.domain.domain
  include_original_headers = true
}