data "yandex_vpc_network" "default" {
  name = var.network_name
}

data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}

resource "yandex_vpc_subnet" "public" {
  name           = "lesson14-public"
  zone           = var.zone
  network_id     = data.yandex_vpc_network.default.id
  v4_cidr_blocks = [var.public_cidr]
}

resource "yandex_vpc_gateway" "nat" {
  name = "lesson14-nat"

  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "private" {
  name       = "lesson14-private-rt"
  network_id = data.yandex_vpc_network.default.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat.id
  }
}

resource "yandex_vpc_subnet" "private" {
  name           = "lesson14-private"
  zone           = var.zone
  network_id     = data.yandex_vpc_network.default.id
  route_table_id = yandex_vpc_route_table.private.id
  v4_cidr_blocks = [var.private_cidr]
}

resource "yandex_vpc_security_group" "public" {
  name       = "lesson14-public-sg"
  network_id = data.yandex_vpc_network.default.id

  ingress {
    protocol       = "TCP"
    description    = "SSH"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    protocol       = "TCP"
    description    = "HTTP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "HTTPS"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "private" {
  name       = "lesson14-private-sg"
  network_id = data.yandex_vpc_network.default.id

  ingress {
    protocol       = "TCP"
    description    = "SSH"
    v4_cidr_blocks = [var.public_cidr]
    port           = 22
  }

  ingress {
    protocol       = "TCP"
    description    = "8080"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 8080
  }

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_compute_instance" "public" {
  name        = "lesson14-public"
  platform_id = "standard-v3"
  zone        = var.zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = 20
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.public.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.public.id]
  }

  metadata = {
    enable-oslogin = "false"
    ssh-keys       = "ubuntu:${file(pathexpand(var.ssh_public_key_path))}"
  }

  connection {
    type        = "ssh"
    host        = self.network_interface[0].nat_ip_address
    user        = "ubuntu"
    private_key = file(pathexpand(var.ssh_private_key_path))
    timeout     = "5m"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo DEBIAN_FRONTEND=noninteractive apt-get install -y nginx",
      "sudo systemctl enable nginx",
      "sudo systemctl restart nginx"
    ]
  }
}

resource "yandex_compute_instance" "private" {
  name        = "lesson14-private"
  platform_id = "standard-v3"
  zone        = var.zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = 20
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.private.id
    nat                = false
    security_group_ids = [yandex_vpc_security_group.private.id]
  }

  metadata = {
    enable-oslogin = "false"
    ssh-keys       = "ubuntu:${file(pathexpand(var.ssh_public_key_path))}"
  }

  connection {
    type                = "ssh"
    host                = self.network_interface[0].ip_address
    user                = "ubuntu"
    private_key         = file(pathexpand(var.ssh_private_key_path))
    bastion_host        = yandex_compute_instance.public.network_interface[0].nat_ip_address
    bastion_user        = "ubuntu"
    bastion_private_key = file(pathexpand(var.ssh_private_key_path))
    timeout             = "5m"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo DEBIAN_FRONTEND=noninteractive apt-get install -y nginx",
      "sudo systemctl enable nginx",
      "sudo systemctl restart nginx"
    ]
  }
}
