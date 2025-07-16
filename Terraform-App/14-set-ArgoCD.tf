data "kubectl_file_documents" "argocd_app" {
  content = file("${path.module}/../argocd-msa-app.yaml")
}

resource "kubernetes_manifest" "argocd_msa_app" {
  for_each = data.kubectl_file_documents.argocd_app.manifests
  manifest = each.value

  depends_on = [helm_release.argocd]
}