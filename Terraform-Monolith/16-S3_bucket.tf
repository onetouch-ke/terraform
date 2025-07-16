resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "ecr_archive_bucket" {
  bucket        = "ecr-archive-${random_id.bucket_suffix.hex}"
  force_destroy = true

  tags = {
    Name        = "ECR Archive Bucket"
    Environment = "dev"
  }
}

resource "aws_s3_bucket_versioning" "ecr_archive_versioning" {
  bucket = aws_s3_bucket.ecr_archive_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "ecr_archive_encryption" {
  bucket = aws_s3_bucket.ecr_archive_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
