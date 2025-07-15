# EKS Cluster IAM Role 생성
resource "aws_iam_role" "Monolith_eks_cluster_role" {
  name = "Monolith_eks_cluster_role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# IAM Role에 정책 부착
resource "aws_iam_role_policy_attachment" "Monolith_eks_cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.Monolith_eks_cluster_role.name
}

resource "aws_iam_role_policy_attachment" "Monolith_eks_cluster_AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.Monolith_eks_cluster_role.name
}

# EKS Cluster 생성
resource "aws_eks_cluster" "Monolith_eks_cluster" {
  name     = "Monolith_eks_cluster"
  role_arn = aws_iam_role.Monolith_eks_cluster_role.arn
  
  version = "1.32" # 최신버전은 에러 발생 하는 경우도 있음 

  vpc_config {
    subnet_ids              = [aws_subnet.Monolith_pri_subnet_2a.id, aws_subnet.Monolith_pri_subnet_2c.id]
    endpoint_public_access  = true
    endpoint_private_access = false
    security_group_ids      = [aws_security_group.Monolith_sg_eks_node_group.id]
  }

  # 의존성
  depends_on = [
    aws_iam_role_policy_attachment.Monolith_eks_cluster_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.Monolith_eks_cluster_AmazonEKSVPCResourceController,
  ]
}