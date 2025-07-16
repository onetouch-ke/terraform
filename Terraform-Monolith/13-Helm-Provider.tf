data "aws_eks_cluster" "main" {
  name = aws_eks_cluster.MSA_eks_cluster.name
}

data "aws_eks_cluster_auth" "auth" {
  name = aws_eks_cluster.MSA_eks_cluster.name
}

provider "helm" {
  kubernetes = {
    host                   = aws_eks_cluster.MSA_eks_cluster.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.MSA_eks_cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.auth.token
  }
}
