resource "aws_ecr_repository" "frontend" {
  name                 = "frontend"
  image_tag_mutability = "MUTABLE" # 태그 덮어쓰기 허용 (immutable도 가능)

  image_scanning_configuration {
    scan_on_push = true # 푸시 시 보안 스캔
  }

  tags = {
    Name        = "frontend-ecr"
    Environment = "dev"
  }
}
