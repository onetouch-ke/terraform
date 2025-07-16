# 클러스터 참조
data "aws_eks_cluster" "MSA_eks_cluster" {
  name = "MSA-cluster" # 클러스터 이름에 맞게 수정
}

# OIDC Provider 정의
resource "aws_iam_openid_connect_provider" "oidc" {
  client_id_list  = ["sts.amazonaws.com"]
  url             = data.aws_eks_cluster.MSA_eks_cluster.identity[0].oidc[0].issuer
  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da0ecd01e10"] # 서울 리전 기본값
}

# ALB Controller용 IRSA Role
resource "aws_iam_role" "alb_controller" {
  name = "alb-controller-irsa-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.oidc.arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${replace(data.aws_eks_cluster.MSA_eks_cluster.identity[0].oidc[0].issuer, "https://", "")}:sub" = "system:serviceaccount:kube-system:aws-load-balancer-controller"
          }
        }
      }
    ]
  })
}
