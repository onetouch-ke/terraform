resource "helm_release" "alb_controller" {
  name       = "alb-controller"
  chart      = "${path.module}/../alb-controller"
  namespace  = "kube-system"
  create_namespace = true

  set {
    name  = "clusterName"
    value = aws_eks_cluster.Monolith_eks_cluster.name
  }

  set {
    name  = "vpcId"
    value = aws_eks_cluster.Monolith_eks_cluster.vpc_config[0].vpc_id
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.alb_controller.arn
  }
}