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
  default = ["multi-frontend", "multi-backend-users", "multi-backend-boards"]
}