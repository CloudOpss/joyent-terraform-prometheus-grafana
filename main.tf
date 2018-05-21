#
# Remote State
#
terraform {
  required_version = ">= 0.11.0"

  backend "manta" {
    path       = "terraform-state/joyent-terraform-prometheus-grafana/"
    objectName = "terraform.tfstate"
  }
}

#
# Providers
#
provider "triton" {
  version = ">= 0.5.1"
}

#
# Data sources
#
data "triton_image" "ubuntu" {
  name        = "ubuntu-16.04"
  type        = "lx-dataset"
  most_recent = true
}

data "triton_network" "public" {
  name = "Joyent-SDC-Public"
}

data "triton_network" "private" {
  name = "My-Fabric-Network"
}

data "triton_datacenter" "current" {}

data "triton_account" "current" {}

#
# Locals
#
locals {
  cmon_dns_suffix = "cmon.${data.triton_datacenter.current.name}.${var.cmon_fqdn_base}"
  cmon_endpoint   = "cmon.${data.triton_datacenter.current.name}.${var.cmon_fqdn_base}"
  grafana_address = "${var.grafana_cns_service_name}.svc.${data.triton_account.current.id}.${data.triton_datacenter.current.name}.${var.cns_fqdn_base}"
}

#
# Machines
#
resource "triton_machine" "grafana" {
  name    = "${var.name}-grafana"
  package = "${var.package}"
  image   = "${data.triton_image.ubuntu.id}"

  firewall_enabled = true

  networks = [
    "${data.triton_network.public.id}",
    "${data.triton_network.private.id}",
  ]

  cns {
    services = ["${var.grafana_cns_service_name}"]
  }

  metadata {
    prometheus_version = "${var.prometheus_version}"
    prometheus_address = "localhost"
    grafana_version    = "${var.grafana_version}"
    cmon_dns_suffix    = "${var.cmon_dns_suffix != "" ? var.cmon_dns_suffix : local.cmon_dns_suffix}"
    cmon_endpoint      = "${var.cmon_endpoint != "" ? var.cmon_endpoint : local.cmon_endpoint}"
  }
}

#
# Firewall Rules
#
resource "triton_firewall_rule" "ssh" {
  rule        = "FROM any TO tag \"triton.cns.services\" = \"${var.grafana_cns_service_name}\" ALLOW tcp PORT 22"
  enabled     = true
  description = "${var.name} - Allow access from bastion hosts to Prometheus servers."
}

resource "triton_firewall_rule" "grafana_web_access" {
  count = "${length(var.client_access)}"

  rule        = "FROM any TO tag \"triton.cns.services\" = \"${var.grafana_cns_service_name}\" ALLOW tcp PORT 3000"
  enabled     = true
  description = "${var.name} - Allow access from clients to Grafana servers."
}
