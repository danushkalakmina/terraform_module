locals {
  account_number = "105757358087"
  Project        = "Trender"
  Environment    = "Prod"
  region         = "us-east-1"
}

# module "TrenderVpc" {

#   source               = "../../modules/vpc"
#   Project              = local.Project
#   Environment          = local.Environment
#   CidrBlock            = "10.0.0.0/16"
#   AzPublicSubnet1      = "us-east-1a"
#   PublicSubnet1_Block  = "10.0.0.0/19"
#   AzPublicSubnet2      = "us-east-1b"
#   PublicSubnet2_Block  = "10.0.32.0/19"
#   AzPrivateSubnet1     = "us-east-1a"
#   PrivateSubnet1_Block = "10.0.64.0/19"
#   AzPrivateSubnet2     = "us-east-1b"
#   PrivateSubnet2_Block = "10.0.96.0/19"
#   K8sClusterName       = "${local.Project}-${local.Environment}-k8sCluster"
# }

# Create the alb

# module "AlbPublic" {
#   source      = "./modules/alb_public"
#   VpcId       = module.TrenderVpc.VpcId
#   Project     = local.Project
#   Environment = local.Environment
#   DomainName = "sadaham.me"

#   PublicSubnet1 = module.TrenderVpc.PublicSubnet1
#   PublicSubnet2 = module.TrenderVpc.PublicSubnet2

# }

# module "Albinternal" {
#   source      = "./modules/alb_internal"
#   VpcId       = module.TrenderVpc.VpcId
#   Project     = local.Project
#   Environment = local.Environment

#   PrivateSubnet1 = module.TrenderVpc.PrivateSubnet1
#   PrivateSubnet2 = module.TrenderVpc.PrivateSubnet2

# }

# Create the redis cluster

# module "ElastiCache" {
#   source = "./modules/elasticache"
#   VpcId  = module.TrenderVpc.VpcId

#   Project     = local.Project
#   Environment = local.Environment

#   NodeType       = "cache.t2.micro"
#   PrivateSubnets = [module.TrenderVpc.PrivateSubnet1, module.TrenderVpc.PrivateSubnet2]

# }

# module "elasticCacheLogs" {
#   source           = "./modules/cloudwatch"
#   Project          = local.Project
#   Environment      = local.Environment
#   LogGroupName     = "elasticCacheLogs"
#   LogRetentionDays = 30

#   depends_on = [
#     module.ElastiCache
#   ]

# }

################################## BEGINNING OF RABBIT MQ ##################################

# module "RabbitMq" {
#   source         = "./modules/rabbitmq"
#   VpcId          = module.TrenderVpc.VpcId
#   VpcCidr        = "10.0.0.0/16"
#   Project        = local.Project
#   Environment    = local.Environment
#   PrivateSubnets = [module.TrenderVpc.PrivateSubnet1, module.TrenderVpc.PrivateSubnet2]

# }

################################## END OF RABBIT MQ ##################################

# Configure elastic cache with cloud watch log group - Currently terraform doesn't provide this
# resource "null_resource" "ConfigureCloudWatchLogsForElasticCache" {

#   provisioner "local-exec" {
#     # command = "sh ./setupCloudWatch.sh ${module.ElastiCache.ClusterId} elasticcachelogs"
#     command = <<EOT
#     "sed -e "s/\$ClusterName/${module.ElastiCache.ClusterId}/" -e "s/\$LogGroupName/elasticCacheLogs/" ${path.module}/setupCloudWatch.sh"
#     "sh ./setupCloudWatch.sh"
#     EOT
#   }
#     depends_on = [
#     module.elasticCacheLogs
#   ]
# }

# module "mongodb" {
#   source           = "./modules/mongodb"'jsonencode({"LogType"="engine-log"}, {"LogFormat"="json"})'
#   ATLAS_Project_ID = "607fe1a355dfda10a2d88816"
#   ATLAS_PROVIDER   = "AWS"
#   CONTAINER_ID     = "61f757a319e86c2a8f209f4f"
#   AWS_VPC_CIDR     = "10.0.0.0/16"
#   AWS_VPC_ID       = module.vpc.vpcid
#   AWS_ACCOUNT_ID   = local.account_number
#   # route tables
#   public_route_id    = module.vpc.public_route_id
#   private_route_1_id = module.vpc.private_route_1_id
#   private_route_2_id = module.vpc.private_route_2_id

# }

################################## BEGINNING OF HISTORY DATA ##################################

# module "HistoryDataSqsQueue" {
#   source              = "../../modules/sqs_queue"
#   Project             = local.Project
#   Environment         = local.Environment
#   QueueName           = "HistoryDataSqsQueue"
#   MaxMsgSize          = 262144
#   MsgRetentionSeconds = 86400
# }
# module "HistoryDataS3_Bucket" {
#   source                  = "../../modules/s3"
#   Project                 = local.Project
#   Environment             = local.Environment
#   BucketName              = "history-data"
# }
# module "HistoryDataLambdaCloudWatchLogGroup" {
#   source           = "../../modules/cloudwatch"
#   Project          = local.Project
#   Environment      = local.Environment
#   LogGroupName     = "HistoryDataLogGroup"
#   LogRetentionDays = 30
# }

# module "HistoryDataLambdaFunction" {
#   source                = "../../modules/lambda_history_data"
#   Project               = local.Project
#   Environment           = local.Environment
#   AwsRegion             = local.region
#   AwsAccountNumber      = local.account_number
#   CloudWatchLogGroupArn = module.HistoryDataLambdaCloudWatchLogGroup.LogGroupArn
#   S3_BucketArn          = module.HistoryDataS3_Bucket.S3_BucketArn
#   SqsQueueArn           = module.HistoryDataSqsQueue.SqsQueueArn
#   S3_BucketName         = module.HistoryDataS3_Bucket.S3_BucketName
# }

################################## END OF HISTORY DATA ##################################

# # Create the RDS instance

# module "rds" {
#   source = "./modules/rds"

#   Project     = local.Project
#   Environment = local.Environment
#   vpcid       = module.vpc.vpcid

#   dbname = "trendertagdb"
#   db_version = "5.7.mysql_aurora.2.10.0"
#   instance_class = "db.t3.medium"

#   lambda_function_arn = module.history_data.lambda_function_arn
#   username = "admin"
#   password = "hduerHSYr^74H"

#   private_subnet_1 = module.vpc.private_subnet_1
#   private_subnet_2 = module.vpc.private_subnet_2

# }

# module "ses" {
#   source      = "../../modules/ses"
#   Project     = local.Project
#   domain_name = "sadaham.me"
#   zone_id     = "Z097864524JG2W9IXIRVD"
#   aws_region  = local.region
#   sns_email   = "sadaham.r@aeturnum.com"
# }

# module "cf" {
#   source      = "./modules/cf"
#   Project     = local.Project
#   Environment = local.Environment

#   # for front-end
#   domain_name             = "sadaham.me"
#   bucket_website_endpoint = module.s3.bucket_website_endpoint
# }

# module "iam" {
#   source         = "../../modules/iam"
#   Project        = local.Project
#   Environment    = local.Environment
#   domain_name    = "sadaham.me"
#   ses_send_email = "no-reply@sadaham.me"
#   bucket_arn     = module.s3.s3_profile_bucket_arn

#   depends_on = [
#     module.ses
#   ]

# }


# module "eks_cluster" {
#   source       = "./modules/eks_cluster"
#   Project      = local.Project
#   Environment  = local.Environment
#   cluster_name = "${local.Project}-${local.Environment}-k8sCluster"

#   private_subnet_1_id = module.vpc.private_subnet_1
#   private_subnet_2_id = module.vpc.private_subnet_2
#   public_subnet_1_id  = module.vpc.public_subnet_1
#   public_subnet_2_id  = module.vpc.public_subnet_2
# }

# module "eks_managed_node_group_1" {
#   source           = "./modules/eks_managed_node_group"
#   eks_cluster_name = module.eks_cluster.eks_cluster_name
#   node_group_name  = "eks_managed_node_group_1"
#   subnet_ids       = [module.vpc.private_subnet_1, module.vpc.private_subnet_2]
#   desired_size     = 3
#   max_size         = 10
#   min_size         = 2
#   max_unavailable  = 1
#   disk_size        = 20
#   instance_types   = ["t3.large"]
# }
