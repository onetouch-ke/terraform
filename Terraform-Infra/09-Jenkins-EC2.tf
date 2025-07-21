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

resource "aws_instance" "MSA_pub_ec2_jenkins_2a" {
  ami                         = "ami-056a29f2eddc40520"
  instance_type               = "t3.medium"
  vpc_security_group_ids      = [aws_security_group.MSA_sg_bastion.id]
  subnet_id                   = aws_subnet.MSA_pub_subnet_2a.id
  key_name                    = "ch-01"
  associate_public_ip_address = true
  iam_instance_profile    = aws_iam_instance_profile.jenkins_profile.name

  user_data = <<-EOF
              #!/bin/bash
              apt update -y

              apt install java-17-amazon-corretto -y

              curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
                /usr/share/keyrings/jenkins-keyring.asc > /dev/null

              echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
                https://pkg.jenkins.io/debian binary/ | sudo tee \
                /etc/apt/sources.list.d/jenkins.list > /dev/null

              apt install jenkins -y  

              systemctl enable jenkins
              systemctl start jenkins

              apt -y install git

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

