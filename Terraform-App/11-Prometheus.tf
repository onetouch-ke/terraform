# resource "helm_release" "prometheus" {
#   name       = "prometheus"
#   repository = "https://prometheus-community.github.io/helm-charts"
#   chart      = "prometheus"
#   version    = "25.21.0"
#   namespace  = "monitoring"

#   set {
#     name  = "server.persistentVolume.storageClass"
#     value = "gp2"
#   }

#   depends_on = [kubernetes_namespace.monitoring]
# }

# EBS CSI Driver 먼저 설치
resource "helm_release" "ebs_csi_driver" {
  name       = "aws-ebs-csi-driver"
  namespace  = "kube-system"
  repository = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
  chart      = "aws-ebs-csi-driver"
  version    = "2.30.0"

  set {
    name  = "controller.serviceAccount.create"
    value = "true"
  }

  set {
    name  = "controller.serviceAccount.name"
    value = "ebs-csi-controller-sa"
  }

  set {
    name  = "node.serviceAccount.name"
    value = "ebs-csi-controller-sa"
  }

  set {
    name  = "storageClasses[0].name"
    value = "ebs-sc"
  }

  set {
    name  = "storageClasses[0].provisioner"
    value = "ebs.csi.aws.com"
  }

  set {
    name  = "storageClasses[0].volumeBindingMode"
    value = "WaitForFirstConsumer"
  }

  set {
    name  = "storageClasses[0].reclaimPolicy"
    value = "Delete"
  }

  set {
    name  = "storageClasses[0].allowVolumeExpansion"
    value = "true"
  }
}

# Prometheus 설치 시 ebs-sc 사용
resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  # version    = "25.21.0"
  namespace  = "monitoring"

  set {
    name  = "server.persistentVolume.storageClass"
    value = "ebs-sc"
  }

  depends_on = [
    kubernetes_namespace.monitoring,
    helm_release.ebs_csi_driver  # 반드시 먼저 설치되도록 설정
  ]
}
