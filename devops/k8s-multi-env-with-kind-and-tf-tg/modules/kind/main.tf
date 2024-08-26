terraform {
  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "0.6.0"
    }
  }
}

provider "kind" {}

resource "kind_cluster" "kindcluster" {
  name = var.cluster_name
}

variable "cluster_name" {
  description = "Nom du cluster KIND."
  type        = string
  default     = "kindcluster"
}
