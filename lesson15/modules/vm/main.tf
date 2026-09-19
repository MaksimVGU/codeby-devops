data "yandex_compute_image" "this" {
  family = var.image_family
}

locals {
  selected_subnets = [
    for subnet in values(var.subnets) : subnet
    if subnet.network_id == var.vpc_id && subnet.zone == var.zone
  ]

  selected_subnet_id = try(local.selected_subnets[0].id, null)
}

resource "yandex_compute_instance" "this" {
  name        = var.name
  hostname    = var.name
  platform_id = "standard-v3"
  zone        = var.zone

  resources {
    cores  = var.cores
    memory = var.memory
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.this.id
      size     = var.disk_size_gb
    }
  }

  network_interface {
    subnet_id          = local.selected_subnet_id
    nat                = var.nat
    security_group_ids = [var.security_group_id]
  }

  metadata = {
    enable-oslogin = "false"
    ssh-keys       = "ubuntu:${var.ssh_public_key}"
  }

  lifecycle {
    precondition {
      condition     = length(local.selected_subnets) == 1
      error_message = "Нужна одна subnet для Zone."
    }
  }
}
