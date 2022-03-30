resource "aws_lb" "AlbInternal" {
  name               = "${var.Project}-${var.Environment}-InternalAlb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.AlbInternalSecurityGroup.id]
  subnets            = [var.PrivateSubnet1, var.PrivateSubnet2]

  enable_deletion_protection = false

  tags = {
    visibility = "internal"
  }
}

resource "aws_alb_listener" "HttpListner" {
  load_balancer_arn = aws_lb.AlbInternal.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Invalid"
      status_code  = "200"
    }
  }

}
