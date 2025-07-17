resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  version    = "25.21.0"
  namespace  = "monitoring"

  set {
    name  = "server.persistentVolume.storageClass"
    value = "gp2"
  }

  depends_on = [kubernetes_namespace.monitoring]
}