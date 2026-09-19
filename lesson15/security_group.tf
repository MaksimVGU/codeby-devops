resource "yandex_vpc_security_group" "lesson15" {
  name        = "lesson15-security-group"
  description = "SG lesson15"
  network_id  = var.vpc_id

  ingress {
    protocol       = "TCP"
    description    = "SSH"
    v4_cidr_blocks = [var.ssh_cidr]
    port           = 22
  }

  ingress {
    protocol       = "ICMP"
    description    = "ICMP"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol       = "ANY"
    description    = "Выход"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
