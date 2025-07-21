resource "aws_instance" "MSA_pub_ec2_Jenkins_2a" {
  ami                         = "ami-0cd4eb0ae8debf650"
  instance_type               = "t2.medium"
  vpc_security_group_ids      = [aws_security_group.MSA_sg_bastion.id]
  subnet_id                   = aws_subnet.MSA_pub_subnet_2a.id
  key_name                    = "ch-01"
  associate_public_ip_address = true
  iam_instance_profile    = aws_iam_instance_profile.bastion_profile.name

  user_data = <<-EOF
              #!/bin/bash
              # Amazon이 제공하는 JDK(Jenkins 호환용)
              dnf install -y java-17-amazone-corretto

              wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
              rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

              # Jenkins 설치
              dnf install jenkins -y   
              
              # Jenkins start
              systemctl enable jenkins
              systemctl start jenkins

              #firewalld 설치
              dnf install -y firewalld

              #firewalld 시작
              systemctl start firewalld

              #jenkins가 기본적으로 8080포트를 사용하므로 8080포트를 열어준다.
              firewall-cmd --permanent --add-port=8080/tcp

              # 방화벽 설정 적용
              firewall-cmd --reload

              # 깃 설치 - jenkins에서 git의 token을 인증받기위해 git이 설치되어있어야함
              dnf -y install git
              
              EOF

  root_block_device {
    volume_size = "8"
    volume_type = "gp2"
    tags = {
      "Name" = "MSA_pub_ec2_Jenkins_2a"
    }
  }

  tags = {
    "Name" = "MSA_pub_ec2_Jenkins_2a"
  }

}