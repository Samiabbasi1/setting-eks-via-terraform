resource "aws_eks_cluster" "eks_cluster" {
  name = var.project_name
  role_arn = var.eks_cluster_role_arn
  version = "1.27"
  vpc_config {
    endpoint_private_access = false
    endpoint_public_access = true
    subnet_ids = [
        var.pub_sub1_id,
        var.pub_sub2_id,
        var.pri_sub3_id,
        var.pri_sub4_id
    ]
  }
}