variable "vpc_cidr_block" {
  type        = string
  description = "The CIDR block for the VPC"
}

variable "subnet_cidr_blocks" {
  type        = list(string)
  description = "The CIDR blocks for the subnets"
}

variable "availability_zones" {
  type        = list(string)
  description = "The availability zones for the subnets"
}

variable "cluster_name" {
  type        = string
  description = "The name of the EKS cluster"
}

variable "kubernetes_version" {
  type        = string
  description = "The Kubernetes version to use for the EKS cluster"
}

variable "region" {
  type        = string
  description = "The AWS region"
  default     = "us-east-1"
}

variable "tag" {
  type        = string
  description = "Tag prefix for resources"
  default     = "nav-eks"
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
