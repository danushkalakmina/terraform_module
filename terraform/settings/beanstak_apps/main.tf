module "CoreApp" {
  source         = "../../modules/beanstalk_application"
  AppName        = "TrenderCoreService"
  Appdescription = "TrenderCoreService"
}

module "TwitterConnectorApp" {
  source         = "../../modules/beanstalk_application"
  AppName        = "TwitterConnectorApp"
  Appdescription = "TwitterConnectorApp"
}

module "ConnectorBridge" {
  source         = "../../modules/beanstalk_application"
  AppName        = "ConnectorBridge"
  Appdescription = "ConnectorBridge"
}