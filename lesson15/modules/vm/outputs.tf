output "id" {
  value = yandex_compute_instance.this.id
}

output "name" {
  value = yandex_compute_instance.this.name
}

output "zone" {
  value = yandex_compute_instance.this.zone
}

output "subnet_id" {
  value = local.selected_subnet_id
}

output "internal_ip" {
  value = yandex_compute_instance.this.network_interface[0].ip_address
}

output "nat_ip" {
  value = yandex_compute_instance.this.network_interface[0].nat_ip_address
}
