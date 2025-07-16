# -------------------------------
# IAM Role for Bastion
# -------------------------------
resource "aws_iam_role" "bastion_eks_role" {
  name = "bastion-eks-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

# EKS 클러스터 정책 (기존 유지)
resource "aws_iam_role_policy_attachment" "bastion_eks_policy" {
  role       = aws_iam_role.bastion_eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# EKS 클러스터 조회 권한 (추가된 부분)
resource "aws_iam_role_policy" "bastion_eks_describe_cluster" {
  name = "bastion-eks-describe-cluster"
  role = aws_iam_role.bastion_eks_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "eks:DescribeCluster"
        ],
        Resource = "*"
      }
    ]
  })
}

# 인스턴스 프로파일
resource "aws_iam_instance_profile" "bastion_profile" {
  name = "bastion-profile"
  role = aws_iam_role.bastion_eks_role.name
}

resource "aws_instance" "MSA_pub_ec2_bastion_2a" {
  ami                         = "ami-056a29f2eddc40520"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.MSA_sg_bastion.id]
  subnet_id                   = aws_subnet.MSA_pub_subnet_2a.id
  key_name                    = "tg-01"
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              export DEBIAN_FRONTEND=noninteractive

              apt-get update -y
              apt-get install -y unzip curl ca-certificates gnupg software-properties-common apt-transport-https lsb-release

              # AWS CLI 설치
              curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
              unzip awscliv2.zip
              ./aws/install

              # kubectl 설치
              curl -LO "https://dl.k8s.io/release/v1.30.1/bin/linux/amd64/kubectl"
              chmod +x kubectl
              mv kubectl /usr/local/bin/

              # Helm 설치
              curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

              # Kubeconfig 연결
              /usr/local/bin/aws eks update-kubeconfig \
                --region ap-northeast-2 \
                --name ${aws_eks_cluster.MSA_eks_cluster.name}

              # 실행 결과 로그 저장
              echo "---- kubectl ----" > /home/ubuntu/setup.log
              kubectl version --client >> /home/ubuntu/setup.log 2>&1
              echo "---- helm ----" >> /home/ubuntu/setup.log
              helm version >> /home/ubuntu/setup.log 2>&1
              EOF

  root_block_device {
    volume_size = "8"
    volume_type = "gp2"
    tags = {
      "Name" = "MSA_pub_ec2_bastion_2a"
    }
  }

  tags = {
    "Name" = "MSA_pub_ec2_bastion_2a"
  }
}