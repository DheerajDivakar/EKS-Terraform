provider "aws" {
  region = var.region
}

resource "aws_vpc" "eks_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${var.cluster_name}-vpc"
  }
}

resource "aws_subnet" "eks_subnet" {
  count             = length(var.subnet_cidrs)
  cidr_block        = element(var.subnet_cidrs, count.index)
  vpc_id            = aws_vpc.eks_vpc.id
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.cluster_name}-subnet-${count.index}"
  }
}

data "aws_availability_zones" "available" {}

