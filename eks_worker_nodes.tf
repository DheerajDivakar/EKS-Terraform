resource "aws_iam_role" "eks_worker_node_role" {
  name = "${var.cluster_name}-worker-node-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_worker_node_policy_attachment" {
  role       = aws_iam_role.eks_worker_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_launch_configuration" "eks_worker_nodes_lc" {
  name                    = "${var.cluster_name}-worker-nodes"
  image_id                = data.aws_ami.eks_ami.id
  instance_type           = var.instance_type
  iam_instance_profile    = aws_iam_instance_profile.eks_worker_node_instance_profile.name
  associate_public_ip_address = true
  security_groups         = [aws_security_group.eks_worker_sg.id]
  user_data               = <<-EOF
                              #!/bin/bash
                              set -o xtrace
                              /etc/eks/bootstrap.sh ${aws_eks_cluster.eks_cluster.name}
                              EOF
}

resource "aws_autoscaling_group" "eks_worker_nodes_asg" {
  launch_configuration = aws_launch_configuration.eks_worker_nodes_lc.id
  min_size             = var.min_size
  max_size             = var.max_size
  desired_capacity     = var.desired_capacity
  vpc_zone_identifier  = aws_subnet.eks_subnet[*].id
  tag {
    key                 = "kubernetes.io/cluster/${aws_eks_cluster.eks_cluster.name}"
    value               = "owned"
    propagate_at_launch = true
  }
}

