output "subnets" {
  value = {
    for id, subnet in data.yandex_vpc_subnet.this : id => {
      id          = subnet.id
      name        = subnet.name
      zone        = subnet.zone
      network_id  = subnet.network_id
      cidr_blocks = subnet.v4_cidr_blocks
      folder_id   = subnet.folder_id
      labels      = subnet.labels
    }
  }
}
