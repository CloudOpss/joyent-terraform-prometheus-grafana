#
# Variables
#
variable "name" {
  description = "The name of the environment."
  type        = "string"
  default     = "grafana"
}

variable "package" {
  description = "The package to deploy as the Prometheus machine(s)."
  type        = "string"
  default     = "g4-general-4G"
}

variable "private_key_path" {
  description = "The path to the private key to use for provisioning machines."
  type        = "string"
}

variable "user" {
  description = "The user to use for provisioning machines."
  type        = "string"
  default     = "root"
}

variable "grafana_version" {
  description = "The version of Grafana to install. See https://grafana.com/grafana/download."
  default     = "5.1.3"
  type        = "string"
}

variable "prometheus_version" {
  description = "The version of Prometheus to install. See https://prometheus.io/download/."
  default     = "2.2.1"                                                                      # Note: Be sure to change this in the Packer script too.
  type        = "string"
}

variable "grafana_cns_service_name" {
  description = "The Grafana CNS service name. Note: this is the service name only, not the full CNS record."
  type        = "string"
  default     = "grafana"
}

variable "cmon_dns_suffix" {
  description = "The full DNS suffix to use for configuring Prometheus. If omitted, will use default pattern for Joyent Public Cloud."
  type        = "string"
  default     = ""
}

variable "cmon_endpoint" {
  description = "The full address to use for configuring Prometheus. If omitted, will use default pattern for Joyent Public Cloud."
  type        = "string"
  default     = ""
}

variable "cmon_fqdn_base" {
  description = "The fully qualified domain name base for the CNS address - e.g. 'triton.zone' for Joyent Public Cloud."
  type        = "string"
  default     = "triton.zone"
}

variable "cns_fqdn_base" {
  description = "The fully qualified domain name base for the CNS address - e.g. 'cns.joyent.com' for Joyent Public Cloud."
  type        = "string"
  default     = "triton.zone"
}

variable "cmon_cert_file_path" {
  description = <<EOF
The path to the TLS certificate to use for authentication to the CMON endpoint.
The sdc-docker setup script is the easiest way to obtain this -
https://raw.githubusercontent.com/joyent/sdc-docker/master/tools/sdc-docker-setup.sh.
EOF

  type = "string"
}

variable "cmon_key_file_path" {
  description = <<EOF
The path to the TLS key to use for authentication to the CMON endpoint.
The sdc-docker setup script is the easiest way to obtain this -
https://raw.githubusercontent.com/joyent/sdc-docker/master/tools/sdc-docker-setup.sh.
EOF

  type = "string"
}

variable "client_access" {
  description = <<EOF
'From' targets to allow client access to Prometheus' web port - i.e. access from other VMs or public internet.
See https://docs.joyent.com/public-cloud/network/firewall/cloud-firewall-rules-reference#target
for target syntax.
EOF

  type    = "list"
  default = ["all vms"]
}
