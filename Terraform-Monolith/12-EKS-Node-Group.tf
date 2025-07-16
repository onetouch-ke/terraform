# Node Group IAM Role 생성
resource "aws_iam_role" "MSA_eks_node_group_role" {
  name = "MSA_eks_node_group_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

# IAM Role에 정책 추가
resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.MSA_eks_node_group_role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.MSA_eks_node_group_role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.MSA_eks_node_group_role.name
}

# Node Group 생성
resource "aws_eks_node_group" "MSA_eks_node_group" {
  cluster_name    = aws_eks_cluster.MSA_eks_cluster.name
  node_group_name = "MSA_eks_node_group"
  node_role_arn   = aws_iam_role.MSA_eks_node_group_role.arn
  subnet_ids      = [aws_subnet.MSA_pri_subnet_2a.id, aws_subnet.MSA_pri_subnet_2c.id]


  tags = {
    "k8s.io/cluster_autoscaler/enabled"               = "true"
    "k8s.io/cluster_autoscaler/MSA_eks_cluster" = "owned"
  }

  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 2
  }

  ami_type       = "AL2_x86_64"
  instance_types = ["t3.large"]
  disk_size      = 20

  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy
  ]
}
