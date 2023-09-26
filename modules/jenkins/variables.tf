variable "namespace" {
  description = "Kubernetes namespace where Jenkins will be deployed."
}

variable "jenkins_chart_version" {
  description = "Jenkins Helm chart version."
  type        = string
}

