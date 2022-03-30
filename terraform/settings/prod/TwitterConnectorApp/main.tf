module "twitter_conector" {
  source = "../../modules/beanstalk"

  # application and environment common variables
  service_name         = "twitter"
  project              = local.project
  environment          = local.environment
  domain_name          = "sadaham.me"
  alb_dns_name         = data.aws_lb.public_alb.dns_name
  alb_zone_id          = data.aws_lb.public_alb.zone_id
  iam_instance_profile = data.aws_iam_instance_profile.iam_profile.name

  # eb environment variables
  stack_name = "64bit Amazon Linux 2 v3.3.10 running Python 3.8"
  # General options variables
  vpcid            = data.aws_vpc.trender_vpc.id
  private_subnet_1 = data.aws_subnet.private_subnet_1.id
  private_subnet_2 = data.aws_subnet.private_subnet_2.id
  public_subnet_1  = data.aws_subnet.public_subnet_1.id
  public_subnet_2  = data.aws_subnet.public_subnet_2.id
  EC2KeyName       = "tredertag-key"
  instanceType_1   = "t2.micro"
  instanceType_2   = "t2.medium"
  shared_alb_arn   = data.aws_lb.public_alb.arn

  ENV               = "development"
  health_check_path = "/health"

  MinSize = 2
  MaxSize = 6

  lb_port = "443"
}
