variable "cluster" {}
variable "namespace" {}
variable "external_dns_chart_values" {}
variable "enable_opa" { default="true" }
variable "opa_failure_policy" {}