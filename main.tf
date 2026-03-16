module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block     = var.vpc_cidr_block
  subnet_cidr_blocks = var.subnet_cidr_blocks
  availability_zones = var.availability_zones
  cluster_name       = var.cluster_name
  tag                = var.tag
}

module "iam" {
  source = "./modules/iam"

  cluster_name = var.cluster_name
}

module "security" {
  source = "./modules/security"

  cluster_name = var.cluster_name
  vpc_id       = module.vpc.vpc_id
}

module "eks" {
  source = "./modules/eks"

  cluster_name       = var.cluster_name
  kubernetes_version = var.kubernetes_version
  subnet_ids         = module.vpc.subnet_ids
  cluster_role_arn   = module.iam.eks_cluster_role_arn
  eks_cluster_sg_id  = module.security.eks_cluster_sg_id
}


module "nodegroup" {
  source = "./modules/nodegroup"

  cluster_name  = module.eks.cluster_name
  subnet_ids    = module.vpc.subnet_ids
  node_role_arn = module.iam.eks_worker_node_role_arn
  instance_type = var.instance_type
  desired_size  = var.desired_size
  min_size      = var.min_size
  max_size      = var.max_size
  tag           = var.tag
}



