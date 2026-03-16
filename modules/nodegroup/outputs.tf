output "node_group_name" {
  value = aws_eks_node_group.worker_nodes.node_group_name
}

output "node_group_status" {
  value = aws_eks_node_group.worker_nodes.status
}
