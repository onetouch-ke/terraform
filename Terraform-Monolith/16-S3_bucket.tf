resource "aws_s3_bucket" "ecr_archive_bucket" {
  bucket        = "my-ecr-archive-bucket" # 버킷 이름은 전역 고유해야 함
  force_destroy = true                    # 버킷 내 객체까지 함께 삭제

  tags = {
    Name        = "ECR Archive Bucket"
    Environment = "dev"
  }
}

# 선택: 버전 관리 설정
resource "aws_s3_bucket_versioning" "ecr_archive_versioning" {
  bucket = aws_s3_bucket.ecr_archive_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# 선택: 서버측 암호화 설정
resource "aws_s3_bucket_server_side_encryption_configuration" "ecr_archive_encryption" {
  bucket = aws_s3_bucket.ecr_archive_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
