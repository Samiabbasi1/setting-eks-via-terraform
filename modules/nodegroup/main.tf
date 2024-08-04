resource "aws_eks_node_group" "node_group" {
  cluster_name = var.eks_cluster_name
  node_group_name = "todo-app-node-group"
  node_role_arn = var.node_group_arn
  subnet_ids = [
    var.pri_sub3_id,
    var.pri_sub4_id
  ]
  scaling_config {
    desired_size = 2
    max_size = 2
    min_size = 2
  }
  ami_type = "AL2_x86_64"
  capacity_type = "ON_DEMAND"
  disk_size = 10
  force_update_version = false

  instance_types = ["t3.small"]
  labels = {
    role = "todo-app-node-group-role"
    name = "todo-app-node-group"
  }
  version = "1.27"
}