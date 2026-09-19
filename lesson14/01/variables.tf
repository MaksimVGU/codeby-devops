variable "zone" {
  type    = string
  default = "ru-central1-a"
}

variable "network_name" {
  type    = string
  default = "default"
}

variable "public_cidr" {
  type    = string
  default = "10.250.0.0/24"
}

variable "private_cidr" {
  type    = string
  default = "10.251.0.0/24"
}

variable "ssh_private_key_path" {
  type    = string
  default = "~/.ssh/id_ed25519"
}

variable "ssh_public_key_path" {
  type    = string
  default = "~/.ssh/id_ed25519.pub"
}
