module "vpc" {
  source        = "../modules/vpc"
  region        = var.region
  projectname   = var.projectname
  vpc_cidr      = var.vpc_cidr
  pub_sub1_cidr = var.pub_sub1_cidr
  pub_sub2_cidr = var.pub_sub2_cidr
  pri_sub3_cidr = var.pri_sub3_cidr
  pri_sub4_cidr = var.pri_sub4_cidr
}

module "nat-GW" {
  source      = "../modules/nat-gw"
  igw_id      = module.vpc.igw_id
  vpc_id      = module.vpc.vpc_id
  pub_sub1_id = module.vpc.pub_sub1_id
  pub_sub2_id = module.vpc.pub_sub2_id
  pri_sub3_id = module.vpc.pri_sub3_id
  pri_sub4_id = module.vpc.pri_sub4_id
}

module "iam" {
  source       = "../modules/iam"
  project_name = var.projectname
}

module "eks" {
  source               = "../modules/eks"
  project_name         = var.projectname
  eks_cluster_role_arn = module.iam.eks_cluster_role_arn
  pub_sub1_id          = module.vpc.pub_sub1_id
  pub_sub2_id          = module.vpc.pub_sub2_id
  pri_sub3_id          = module.vpc.pri_sub3_id
  pri_sub4_id          = module.vpc.pri_sub4_id
}

module "nodegroup" {
  source           = "../modules/nodegroup"
  node_group_arn   = module.iam.node_group_role_arn
  pri_sub3_id      = module.vpc.pri_sub3_id
  pri_sub4_id      = module.vpc.pri_sub4_id
  eks_cluster_name = module.eks.eks_cluster_name
}