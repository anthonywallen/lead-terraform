provider "kubernetes" {
  config_path            = var.kube_config_path
}

provider "helm" {
  alias           = "toolchain"
  version         = "0.10.4"
  namespace       = var.namespace
  tiller_image    = "gcr.io/kubernetes-helm/tiller:v2.15.1"
  service_account = var.tiller_service_account

  kubernetes {
    config_path            = var.kube_config_path
  }
}

provider "helm" {
  alias           = "system"
  version         = "0.10.4"
  namespace       = var.namespace
  tiller_image    = "gcr.io/kubernetes-helm/tiller:v2.15.1"
  service_account = var.tiller_service_account

  kubernetes {
    config_path            = var.kube_config_path
  }
}

module "sdm" {
  source = "../../../../modules/lead/sdm"
  product_stack = var.product_stack
  namespace = var.namespace
  system_namespace = var.system_namespace
  root_zone_name = var.root_zone_name
  cluster = var.cluster_id
  sdm_version = var.sdm_version
  product_version = var.product_version
  slack_bot_token = var.slack_bot_token
  slack_client_signing_secret = var.slack_client_signing_secret

  providers = {
    helm.system    = helm.system
    helm.toolchain = helm.toolchain
  }
}
