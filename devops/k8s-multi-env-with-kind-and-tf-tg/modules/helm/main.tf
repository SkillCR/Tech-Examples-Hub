terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.16.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.6.0"
    }
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "kind-kindcluster"
}

provider "helm" {
  kubernetes {
    config_path    = "~/.kube/config"
    config_context = "kind-kindcluster"
  }
}

resource "kubernetes_namespace" "example" {
  metadata {
    name = var.namespace_name
  }
}

resource "helm_release" "nginx" {
  name       = "nginx"
  namespace  = kubernetes_namespace.example.metadata[0].name
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx"

  set {
    name  = "service.type"
    value = "ClusterIP"
  }

  set {
    name  = "replicaCount"
    value = "2"
  }
}

variable "namespace_name" {
  description = "Le nom de l'espace de noms Kubernetes."
  type        = string
}
