resource "helm_release" "argocd" {
  name             = "argo-cd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true

  # ArgoCD Server Insecure 설정
  set {
    name  = "server.insecure"
    value = "true"
  }

  # 서버 실행 시 --insecure 인자 추가 (선택)
  set {
    name  = "server.extraArgs"
    value = "{--insecure}"
  }

  # LoadBalancer로 외부 노출
  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }

  # Helm Chart에서 CRD 자동 설치
  set {
    name  = "installCRDs"
    value = "true"
  }

  # configs.params 설정 방식으로 insecure 설정 (선택)
  set {
    name  = "configs.params.server.insecure"
    value = "true"
  }
}
