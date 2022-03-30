
resource "aws_lb" "AlbPublic" {
  name               = "${var.Project}-${var.Environment}-AlbPublic"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.AlbPublicSecurityGroup.id]
  subnets            = [var.PublicSubnet1, var.PublicSubnet1]

  enable_deletion_protection = false

  tags = {
    visibility = "public"
  }
}

resource "aws_alb_listener" "HttpListener" {
  load_balancer_arn = aws_lb.AlbPublic.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

}

data "aws_acm_certificate" "DomainCertificate" {
  domain      = var.DomainName
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}


resource "aws_lb_listener" "HttpsListener" {
  load_balancer_arn = aws_lb.AlbPublic.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.DomainCertificate.arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Invalid"
      status_code  = "200"
    }
  }
}
