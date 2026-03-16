variable "cluster_name" {
  type        = string
  description = "The name of the EKS cluster"
}

variable "subnet_ids" {
  type        = list(string)
  description = "The subnet IDs for the node group"
}

variable "node_role_arn" {
  type        = string
  description = "The IAM role ARN for the worker nodes"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type for worker nodes"

}

variable "desired_size" {
  type        = number
  description = "Desired number of worker nodes"

}

variable "min_size" {
  type        = number
  description = "Minimum number of worker nodes"

}

variable "max_size" {
  type        = number
  description = "Maximum number of worker nodes"

}

variable "tag" {
  type        = string
  description = "Tag prefix for resources"
}
