#
# Outputs
#
output "grafana_primaryip" {
  value = ["${triton_machine.grafana.*.primaryip}"]
}

output "grafana_address" {
  value = "http://${local.grafana_address}:3000/"
}
