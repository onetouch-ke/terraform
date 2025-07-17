resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  namespace  = "monitoring"
  version    = "25.21.0"

  timeout    = 300
  wait       = true
  atomic     = true
  depends_on = [kubernetes_namespace.monitoring]
}
