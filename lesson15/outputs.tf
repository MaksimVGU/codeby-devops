output "vpc_id" {
  value = var.vpc_id
}

output "subnets" {
  value = module.vpc_subnets.subnets
}

output "security_group_id" {
  value = yandex_vpc_security_group.lesson15.id
}

output "vm_id" {
  value = module.vm.id
}

output "vm_name" {
  value = module.vm.name
}

output "vm_zone" {
  value = module.vm.zone
}

output "vm_subnet_id" {
  value = module.vm.subnet_id
}

output "vm_internal_ip" {
  value = module.vm.internal_ip
}

output "vm_nat_ip" {
  value = module.vm.nat_ip
}
