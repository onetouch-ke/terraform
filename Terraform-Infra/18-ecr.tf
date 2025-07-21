resource "aws_ecr_repository" "repos" {
  for_each = toset(var.ecr_repositories)

  name = each.key

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Project = "OneTouch"
  }
}

variable "ecr_repositories" {
  default = ["multi_frontend", "multi_backend_users", "multi_backend_boards"]
}