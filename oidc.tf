resource "aws_iam_openid_connect_provider" "eks_oidc_provider" {
  url = "https://oidc.eks.${var.region}.amazonaws.com/id/${aws_eks_cluster.eks_cluster.id}"
  client_id_list = ["sts.amazonaws.com"]
  thumbprint_list = ["${aws_eks_cluster.eks_cluster.certificate_authority[0].data}"]
}

