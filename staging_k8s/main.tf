module "vpc" {

  source      = "./modules/vpc"
  project     = local.project
  environment = local.environment

  cidr_block = "10.10.0.0/16"

  public_subnet_1        = "us-east-1a"
  public_subnet_1_block  = "10.10.0.0/19"
  public_subnet_2        = "us-east-1b"
  public_subnet_2_block  = "10.10.32.0/19"
  private_subnet_1       = "us-east-1a"
  private_subnet_1_block = "10.10.64.0/19"
  private_subnet_2       = "us-east-1b"
  private_subnet_2_block = "10.10.96.0/19"
  account_number         = local.account_number

  k8s_cluster_name = "${local.project}-${local.environment}-${var.cluster_name}"
}

module "ec2" {

  source      = "./modules/ec2"
  project     = local.project
  environment = local.environment
  vpc_id      = module.vpc.vpcid
  ec2SubnetId = module.vpc.public_subnet_1
}

module "eks_cluster" {
  source       = "./modules/eks_cluster"
  project      = local.project
  environment  = local.environment
  cluster_name = "${local.project}-${local.environment}-${var.cluster_name}"
  vpcId        = module.vpc.vpcid
  # security_groups = module.ec2.sg_id

  private_subnet_1_id = module.vpc.private_subnet_1
  private_subnet_2_id = module.vpc.private_subnet_2
  public_subnet_1_id  = module.vpc.public_subnet_1
  public_subnet_2_id  = module.vpc.public_subnet_2
}

module "eks_managed_node_group_1" {
  source           = "./modules/eks_managed_node_group"
  eks_cluster_name = module.eks_cluster.eks_cluster_name
  node_group_name  = "eks_managed_node_group_1"
  subnet_ids       = [module.vpc.private_subnet_1, module.vpc.private_subnet_2]
  desired_size     = 2
  max_size         = 10
  min_size         = 2
  max_unavailable  = 1
  disk_size        = 20
  instance_types   = ["t3.large"]
}
