resource "kubernetes_manifest" "argocd_msa_app" {
  manifest = yamldecode(file("${path.module}/../argocd-msa-app.yaml"))
  depends_on = [helm_release.argocd]
}
