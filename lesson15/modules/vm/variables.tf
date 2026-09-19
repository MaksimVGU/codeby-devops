variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "zone" {
  type = string
}

variable "subnets" {
  type = map(object({
    id          = string
    name        = string
    zone        = string
    network_id  = string
    cidr_blocks = list(string)
    folder_id   = string
    labels      = map(string)
  }))
}

variable "security_group_id" {
  type = string
}

variable "image_family" {
  type = string
}

variable "cores" {
  type = number
}

variable "memory" {
  type = number
}

variable "disk_size_gb" {
  type = number
}

variable "nat" {
  type = bool
}

variable "ssh_public_key" {
  type = string
}
