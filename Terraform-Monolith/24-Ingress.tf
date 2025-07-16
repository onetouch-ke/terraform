resource "helm_release" "ingress" {
  name       = "ingress"
  chart      = "${path.module}/../ingress"
  namespace  = "default"
}
