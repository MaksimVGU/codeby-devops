variable "cloud_id" {
  type = string
}

variable "folder_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "zone" {
  type = string
}

variable "vm_name" {
  type    = string
  default = "lesson15-vm"
}

variable "image_family" {
  type    = string
  default = "ubuntu-2204-lts"
}

variable "cores" {
  type    = number
  default = 2
}

variable "memory" {
  type    = number
  default = 2
}

variable "disk_size_gb" {
  type    = number
  default = 10
}

variable "nat" {
  type    = bool
  default = true
}

variable "ssh_cidr" {
  type = string
}

variable "ssh_public_key" {
  type = string
}
