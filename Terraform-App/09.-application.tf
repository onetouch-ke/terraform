resource "helm_release" "msa_front" {
  name       = "msa-front"
  chart      = "${path.module}/../mychart/frontend"
  namespace  = "default"

  depends_on = [helm_release.alb_controller]
}

resource "helm_release" "msa_boards" {
  name       = "msa-boards"
  chart      = "${path.module}/../mychart/boards"
  namespace  = "default"

  set {
    name  = "mariadb.userName"
    value = var.rds_username
  }

  set {
    name  = "mariadb.rootPassword"
    value = var.rds_password
  }

  depends_on = [helm_release.alb_controller]
}

resource "helm_release" "msa_users" {
  name       = "msa-users"
  chart      = "${path.module}/../mychart/users"
  namespace  = "default"

  set {
    name  = "mariadb.userName"
    value = var.rds_username
  }

  set {
    name  = "mariadb.rootPassword"
    value = var.rds_password
  }

  depends_on = [helm_release.alb_controller]
}

# 변수 선언
variable "rds_password" {
  description = "Password for the MariaDB RDS root user"
  type        = string
  sensitive   = true
}

variable "private_key" {
  description = "SSH private key to connect to bastion"
  type        = string
  sensitive   = true
}

variable "rds_username" {
  description = "Database admin username"
  type        = string
  default     = "MSA_User"  # 또는 원하는 기본값
}