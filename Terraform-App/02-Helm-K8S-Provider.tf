provider "aws" {
  region = "ap-northeast-2"
}

data "aws_eks_cluster" "MSA_eks_cluster" {
  name = "MSA_eks_cluster"   # 실제 Infra에서 만든 클러스터 이름과 맞춰야 함
}

data "aws_eks_cluster_auth" "auth" {
  name = data.aws_eks_cluster.MSA_eks_cluster.name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.MSA_eks_cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.MSA_eks_cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.auth.token
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.MSA_eks_cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.MSA_eks_cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.auth.token
  }
}

