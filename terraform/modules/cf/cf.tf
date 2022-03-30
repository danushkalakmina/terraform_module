# looking for the ssl certificate issued by aws acm
data "aws_acm_certificate" "domain_certificate" {
  domain      = var.domain_name
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}

resource "aws_cloudfront_distribution" "www_distribution" {

  origin {
    custom_origin_config {
      # These are all the defaults.
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }

    # Here we're using our S3 bucket's URL!
    domain_name = var.bucket_website_endpoint
    # This can be any name to identify this origin.
    origin_id = "${var.environment}.${var.domain_name}"
    custom_header {
      name = "Referer"
      value = "FromCloudFrontOnly"
    }
  }

  enabled             = true
  default_root_object = "index.html"

  # All values are defaults from the AWS console.
  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    # This needs to match the `origin_id` above.
    target_origin_id = "${var.environment}.${var.domain_name}"
    min_ttl          = 0
    default_ttl      = 86400
    max_ttl          = 31536000

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  #   aliases = ["${var.www_domain_name}"]
  aliases = ["${var.environment}.${var.domain_name}"] //"www.${var.app}-${var.environment}.${var.domain_name}", 

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  // Here's where our certificate is loaded in!
  viewer_certificate {
    acm_certificate_arn = data.aws_acm_certificate.domain_certificate.arn
    ssl_support_method  = "sni-only"
  }

}
