resource "kubernetes_manifest" "argocd_msa_app" {
  manifest = yamldecode(file("${path.module}/../argocd-msa-app.yaml"))
  depends_on = [aws_eks_cluster.MSA_eks_cluster, aws_eks_node_group.MSA_eks_node_group]
}
