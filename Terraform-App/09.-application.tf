resource "helm_release" "msa_front" {
  name       = "msa-front"
  chart      = "${path.module}/../mychart/frontend"
  namespace  = "default"
}

resource "helm_release" "msa_boards" {
  name       = "msa-boards"
  chart      = "${path.module}/../mychart/boards"
  namespace  = "default"
}

resource "helm_release" "msa_users" {
  name       = "msa-users"
  chart      = "${path.module}/../mychart/users"
  namespace  = "default"
}