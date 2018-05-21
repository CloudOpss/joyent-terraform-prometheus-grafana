#
# Outputs
#
output "grafana_address" {
  value = "http://${local.grafana_address}:3000/"
}
