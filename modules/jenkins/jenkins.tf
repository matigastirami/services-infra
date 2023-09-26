resource "helm_release" "jenkins" {
  name       = "jenkins"
  namespace  = var.namespace
  repository = "https://charts.jenkins.io"
  chart      = "jenkins"
  version    = var.jenkins_chart_version

  set {
    name  = "controller.masterServicePort"
    value = "8080"
  }

  # You can set additional Helm values as needed for your deployment
  # set {
  #   name  = "key"
  #   value = "value"
  # }
}