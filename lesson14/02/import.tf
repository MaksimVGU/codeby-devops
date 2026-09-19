resource "yandex_compute_instance" "manual" {
  allow_recreate            = null
  allow_stopping_for_update = null
  description               = null
  folder_id                 = "b1g049d6goru8bdkddc4"
  gpu_cluster_id            = null
  hostname                  = null
  labels                    = {}
  maintenance_grace_period  = null
  maintenance_policy        = null
  metadata = {
    ssh-keys  = "yc-user:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK6uAur+06BX8VojPfLEEJVFglRTnylocSL68B9rCTme 14maxim4@gmai.com\n"
    user-data = "#cloud-config\ndatasource:\n Ec2:\n  strict_id: false\nssh_pwauth: no\nusers:\n- name: yc-user\n  sudo: ALL=(ALL) NOPASSWD:ALL\n  shell: /bin/bash\n  ssh_authorized_keys:\n  - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK6uAur+06BX8VojPfLEEJVFglRTnylocSL68B9rCTme 14maxim4@gmai.com\n\n"
  }
  name                      = "lesson14-manual"
  network_acceleration_type = "standard"
  platform_id               = "standard-v2"
  reserved_instance_pool_id = null
  service_account_id        = null
  zone                      = "ru-central1-a"
  boot_disk {
    auto_delete = true
    device_name = "fhm1rks31kib0dlr1ru6"
    disk_id     = "fhm1rks31kib0dlr1ru6"
    mode        = "READ_WRITE"
    initialize_params {
      block_size  = 4096
      description = null
      image_id    = "fd85n2sh0jr400ph4b8u"
      kms_key_id  = null
      name        = null
      size        = 20
      snapshot_id = null
      type        = "network-hdd"
    }
  }
  metadata_options {
    aws_v1_http_endpoint = 1
    aws_v1_http_token    = 2
    aws_v2_http_endpoint = 1
    aws_v2_http_token    = 1
    gce_http_endpoint    = 1
    gce_http_token       = 1
  }
  network_interface {
    index              = 0
    ip_address         = "10.128.0.23"
    ipv4               = true
    ipv6               = false
    ipv6_address       = null
    nat                = true
    nat_ip_address     = "158.160.52.212"
    security_group_ids = []
    subnet_id          = "e9bkaojsa2nivqdnp5lc"
  }
  placement_policy {
    host_affinity_rules       = []
    placement_group_id        = null
    placement_group_partition = 0
  }
  resources {
    core_fraction = 100
    cores         = 2
    gpus          = 0
    memory        = 2
  }
  scheduling_policy {
    preemptible = false
  }
}
