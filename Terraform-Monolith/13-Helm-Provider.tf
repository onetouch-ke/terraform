provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.Monolith_eks_cluster.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.Monolith_eks_cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.auth.token
  }
}