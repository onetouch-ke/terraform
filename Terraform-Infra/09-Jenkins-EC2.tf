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

# 인스턴스 프로파일
resource "aws_iam_instance_profile" "jenkins_profile" {
  name = "jenkins-profile"
  role = aws_iam_role.jenkins_role.name
}

resource "aws_instance" "Jenkins" {
  ami                         = "ami-056a29f2eddc40520"
  instance_type               = "t3.medium"
  vpc_security_group_ids      = [aws_security_group.jenkins_sg.id]
  subnet_id                   = aws_subnet.MSA_pub_subnet_2a.id
  key_name                    = "ch-01"
  associate_public_ip_address = true
  iam_instance_profile    = aws_iam_instance_profile.jenkins_profile.name

  user_data = <<-EOF
              #!/bin/bash
              set -e

              # 1. 필수 패키지 설치
              apt-get update -y
              apt-get install -y openjdk-17-jdk curl gnupg2 git
              apt install -y unzip curl

              # 2. AWS CLI 설치
              curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
              unzip awscliv2.zip
              sudo apt install awscli


              # 3. Jenkins 저장소 및 키 등록
              curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
              echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/ > /etc/apt/sources.list.d/jenkins.list

              # 4. Jenkins 설치
              apt-get update -y
              apt-get install -y jenkins

              # 5. Jenkins 서비스 시작 및 자동 실행 설정
              systemctl daemon-reload
              systemctl enable jenkins
              systemctl start jenkins

              # 6. 확인용 로그 출력
              echo "✅ Jenkins 설치 및 실행 완료"
              EOF

  root_block_device {
    volume_size = "8"
    volume_type = "gp2"
    tags = {
      "Name" = "Jenkins"
    }
  }

  tags = {
    "Name" = "Jenkins"
  }
}

resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-sg"
  description = "Allow Jenkins and SSH"
  vpc_id      = aws_vpc.MSA_vpc.id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jenkins-sg"
  }
}
