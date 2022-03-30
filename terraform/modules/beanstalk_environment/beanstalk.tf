# Application configuration
resource "aws_elastic_beanstalk_application" "eb_application" {
  name        = "${var.project}-${var.service_name}"
  description = "${var.project}-${var.service_name}"
  tags = {
    Name    = "${var.project}-${var.service_name}"
    Service = var.service_name
  }

}

# Environment Configurations
resource "aws_elastic_beanstalk_environment" "eb_application_env" {
  name                = "${aws_elastic_beanstalk_application.eb_application.name}-${var.environment}"
  application         = var.BeanstalkAppName
  solution_stack_name = var.stack_name
  tags = {
    Name    = "${aws_elastic_beanstalk_application.eb_application.name}-${var.environment}"
    Service = var.service_name
  }
  # Options settings
  # VPC settings

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = var.vpcid
    resource  = ""
  }
  # Subnets for ec2 instances/ auto scaling groups
  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(", ", var.private_subnets)
    # value    = "subnet-074dcae2e1c74e436, subnet-05b3c33ffe79b1adc"
    resource = ""
  }
  
  # setting {
  #   namespace = "aws:ec2:vpc"
  #   name      = "Subnets"
  #   value     = var.private_subnet_2
  #   resource  = ""
  # }
  # Subnets for load balancers
  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBSubnets"
    value     = var.public_subnet_1
    resource  = ""
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBSubnets"
    value     = var.public_subnet_2
    resource  = ""
  }
  # ELBScheme <- might not required becuse we are already created application load balancer
  # Options settings
  # launchconfiguration settings
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = var.EC2KeyName
    resource  = ""
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = var.iam_instance_profile
    resource  = ""
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = aws_security_group.eb_environment_sg.id
    resource  = ""
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = aws_security_group.eb_environment_sg.id
    resource  = ""
  }
  # Options settings
  # ec2 instance settings
  setting {
    namespace = "aws:ec2:instances"
    name      = "InstanceTypes"
    value     = var.instanceType_1
    resource  = ""
  }
  # setting {
  #   namespace = "aws:ec2:instances"
  #   name      = "InstanceTypes"
  #   value     = var.instanceType_2
  #   resource  = ""
  # }
  # Options settings
  # auto scaling settings settings
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "Availability Zones"
    value     = "Any 2"
    resource  = ""
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = var.MinSize
    resource  = ""
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = var.MaxSize
    resource  = ""
  }

  # Options settings
  # environment type settings
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "LoadBalanced"
    resource  = ""
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
    resource  = ""
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerIsShared"
    value     = true
    resource  = ""
  }
  # Options settings
  # shared loadbalancer settings
  setting {
    namespace = "aws:elbv2:loadbalancer"
    name      = "SharedLoadBalancer"
    value     = var.shared_alb_arn
    resource  = ""
  }
  # Options settings
  # shared loadbalancer host rules/ listeners settings
  setting {
    namespace = "aws:elbv2:listenerrule:app1"
    name      = "HostHeaders"
    value     = "${var.service_name}.${var.domain_name}"
    resource  = ""
  }
  setting {
    namespace = "aws:elbv2:listenerrule:app1"
    name      = "PathPatterns"
    value     = "/*"
    resource  = ""
  }
  setting {
    namespace = "aws:elbv2:listener:${var.lb_port}"
    name      = "Rules"
    value     = "app1"
    resource  = ""
    # value     = var.service_name
  }
  # Options settings
  # health check path //
  # setting {
  #   namespace = "aws:elasticbeanstalk:application"
  #   name      = "Application Healthcheck URL"
  #   value     = var.health_check_path
  # resource = ""
  # }

  # Options settings
  # beanstalk platform management - weekly instance replacemenet
  setting {
    namespace = "aws:elasticbeanstalk:managedactions"
    name      = "ServiceRoleForManagedUpdates"
    value     = "AWSServiceRoleForElasticBeanstalkManagedUpdates"
    resource  = ""
  }

  setting {
    namespace = "aws:elasticbeanstalk:managedactions"
    name      = "ManagedActionsEnabled"
    value     = "true"
    resource  = ""
  }
  setting {
    namespace = "aws:elasticbeanstalk:managedactions"
    name      = "PreferredStartTime"
    value     = "Sat:21:00"
    resource  = ""
  }
  setting {
    namespace = "aws:elasticbeanstalk:managedactions:platformupdate"
    name      = "UpdateLevel"
    value     = "patch"
    resource  = ""
  }
  setting {
    namespace = "aws:elasticbeanstalk:managedactions:platformupdate"
    name      = "InstanceRefreshEnabled"
    value     = "true"
    resource  = ""
  }
  # Options settings
  # application specific environment veriables
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "ENV"
    value     = var.ENV
    resource  = ""
  }

  # lifecycle {
  #   ignore_changes = all
  # }
}

# alb listner and target group
