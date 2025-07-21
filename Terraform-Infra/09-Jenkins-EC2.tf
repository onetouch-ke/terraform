resource "aws_iam_role" "jenkins_role" {
  name = "jenkins-ec2-role"
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

resource "aws_iam_role_policy_attachment" "jenkins_ecr_policy" {
  role       = aws_iam_role.jenkins_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}
resource "aws_iam_instance_profile" "jenkins_profile" {
  name = "jenkins-profile"
  role = aws_iam_role.jenkins_role.name
}


# 인스턴스 프로파일
resource "aws_iam_instance_profile" "jenkins_profile" {
  name = "jenkins-profile"
  role = aws_iam_role.jenkins_role.name
}

resource "aws_instance" "MSA_pub_ec2_jenkins_2a" {
  ami                         = "ami-0ff0bbc5968fcbc61"
  instance_type               = "t2.medium"
  vpc_security_group_ids      = [aws_security_group.MSA_sg_bastion.id]
  subnet_id                   = aws_subnet.MSA_pub_subnet_2a.id
  key_name                    = "ch-01"
  associate_public_ip_address = true
  iam_instance_profile    = aws_iam_instance_profile.jenkins_profile.name

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
                --name ${aws_eks_cluster.MSA_eks_cluster.name} \
                --kubeconfig /home/ubuntu/.kube/config
              
              chown ubuntu:ubuntu /home/ubuntu/.kube/config

              # cert-manager CRD 설치
              kubectl create -f https://github.com/cert-manager/cert-manager/releases/download/v1.14.5/cert-manager.crds.yaml \
                --kubeconfig /home/ubuntu/.kube/config

              # alb-controller CRD 설치
              kubectl create -f https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.7.1/config/crd/bases/elbv2.k8s.aws_targetgroupbindings.yaml \
                --kubeconfig /home/ubuntu/.kube/config

              kubectl create -f https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.7.1/config/crd/bases/elbv2.k8s.aws_ingressclassparams.yaml \
                --kubeconfig /home/ubuntu/.kube/config

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
      "Name" = "MSA_pub_ec2_jenkins_2a"
    }
  }

  tags = {
    "Name" = "MSA_pub_ec2_jenkins_2a"
  }
}

