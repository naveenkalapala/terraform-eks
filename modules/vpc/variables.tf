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

variable "tag" {
  type        = string
  description = "Tag prefix for resources"
}