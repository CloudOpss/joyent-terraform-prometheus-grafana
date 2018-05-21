resource "null_resource" "prometheus_install" {
  triggers {
    machine_ids = "${triton_machine.grafana.*.id[count.index]}"
  }

  depends_on = ["triton_firewall_rule.ssh"]

  connection {
    host        = "${triton_machine.grafana.*.primaryip[count.index]}"
    user        = "${var.user}"
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /tmp/prometheus_installer/",
    ]
  }

  provisioner "file" {
    source      = "${path.module}/scripts/install_prometheus.sh"
    destination = "/tmp/prometheus_installer/install_prometheus.sh"
  }

  provisioner "file" {
    source      = "${var.cmon_cert_file_path}"
    destination = "/tmp/prometheus_installer/cert.pem"
  }

  provisioner "file" {
    source      = "${var.cmon_key_file_path}"
    destination = "/tmp/prometheus_installer/key.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 0755 /tmp/prometheus_installer/install_prometheus.sh",
      "sudo /tmp/prometheus_installer/install_prometheus.sh",
    ]
  }

  # clean up
  provisioner "remote-exec" {
    inline = [
      "rm -rf /tmp/prometheus_installer/",
    ]
  }
}

resource "null_resource" "grafana_install" {
  triggers {
    machine_ids = "${triton_machine.grafana.*.id[count.index]}"
  }

  depends_on = ["triton_firewall_rule.ssh"]

  connection {
    host        = "${triton_machine.grafana.*.primaryip[count.index]}"
    user        = "${var.user}"
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /tmp/grafana_installer/",
    ]
  }

  provisioner "file" {
    source      = "${path.module}/scripts/install_grafana.sh"
    destination = "/tmp/grafana_installer/install_grafana.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 0755 /tmp/grafana_installer/install_grafana.sh",
      "sudo /tmp/grafana_installer/install_grafana.sh",
    ]
  }

  # clean up
  provisioner "remote-exec" {
    inline = [
      "rm -rf /tmp/grafana_installer/",
    ]
  }
}
