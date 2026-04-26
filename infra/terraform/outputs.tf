output "vm_name" {
  description = "Name of the demo VM."
  value       = yandex_compute_instance.vm.name
}

output "vm_internal_ip" {
  description = "Internal IP address of VM."
  value       = yandex_compute_instance.vm.network_interface[0].ip_address
}

output "vm_external_ip" {
  description = "Public IP address of VM."
  value       = yandex_compute_instance.vm.network_interface[0].nat_ip_address
}

output "frontend_url" {
  description = "Frontend proxy URL."
  value       = "http://${yandex_compute_instance.vm.network_interface[0].nat_ip_address}:${var.frontend_proxy_port}"
}

output "grafana_url" {
  description = "Grafana URL."
  value       = "http://${yandex_compute_instance.vm.network_interface[0].nat_ip_address}:${var.grafana_port}"
}

output "jaeger_url" {
  description = "Jaeger UI URL."
  value       = "http://${yandex_compute_instance.vm.network_interface[0].nat_ip_address}:${var.jaeger_ui_port}"
}
