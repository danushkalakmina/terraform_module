resource "aws_elastic_beanstalk_application" "BeanstalkApplication" {
  name        = var.AppName
  description = var.Appdescription
}