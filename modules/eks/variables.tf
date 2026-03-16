variable "cluster_name" {
  type        = string
  description = "The name of the EKS cluster"
}

variable "kubernetes_version" {
  type        = string
  description = "The Kubernetes version to use for the EKS cluster"
}

variable "subnet_ids" {
  type        = list(string)
  description = "The subnet IDs for the EKS cluster"
}

variable "cluster_role_arn" {
  type        = string
  description = "The IAM role ARN for the EKS cluster"
}

variable "eks_cluster_sg_id" {
  type        = string
  description = "The security group ID for the EKS cluster"
}