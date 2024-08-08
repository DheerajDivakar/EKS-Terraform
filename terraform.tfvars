region          = "us-east-1"
cluster_name    = "my-new-cluster"
instance_type   = "t3.medium"
desired_capacity = 2
max_size        = 3
min_size        = 1
vpc_cidr_block  = "10.0.0.0/16"
subnet_cidrs    = ["10.0.1.0/24", "10.0.2.0/24"]

