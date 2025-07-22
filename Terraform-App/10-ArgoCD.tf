resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = "argocd"

  set {
    name  = "server.extraArgs"
    value = "{--insecure}"
  }
  set {
    name  = "server.insecure"
    value = "true"
  }
  set {
    name  = "installCRDs"
    value = "true"
  }

  depends_on = [kubernetes_namespace.argocd, helm_release.alb_controller]
}