output "network_id" {
  value = data.yandex_vpc_network.default.id
}

output "public_subnet_id" {
  value = yandex_vpc_subnet.public.id
}

output "private_subnet_id" {
  value = yandex_vpc_subnet.private.id
}

output "public_vm_id" {
  value = yandex_compute_instance.public.id
}

output "public_vm_ip" {
  value = yandex_compute_instance.public.network_interface[0].nat_ip_address
}

output "private_vm_id" {
  value = yandex_compute_instance.private.id
}

output "private_vm_ip" {
  value = yandex_compute_instance.private.network_interface[0].ip_address
}
