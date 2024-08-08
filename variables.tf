variable "region" {
  description = "The AWS region to create resources in"
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  default     = "demo-cluster"
}

variable "instance_type" {
  description = "The instance type for worker nodes"
  default     = "t3.medium"
}

variable "desired_capacity" {
  description = "The desired capacity of worker nodes"
  default     = 2
}

variable "max_size" {
  description = "The maximum size of the worker node group"
  default     = 3
}

variable "min_size" {
  description = "The minimum size of the worker node group"
  default     = 1
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidrs" {
  description = "CIDR blocks for subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

