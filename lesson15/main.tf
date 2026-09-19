provider "yandex" {
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

module "vpc_subnets" {
  source     = "./modules/vpc_subnets"
  network_id = var.vpc_id
}

module "vm" {
  source            = "./modules/vm"
  name              = var.vm_name
  vpc_id            = var.vpc_id
  zone              = var.zone
  subnets           = module.vpc_subnets.subnets
  security_group_id = yandex_vpc_security_group.lesson15.id
  image_family      = var.image_family
  cores             = var.cores
  memory            = var.memory
  disk_size_gb      = var.disk_size_gb
  nat               = var.nat
  ssh_public_key    = var.ssh_public_key
}
