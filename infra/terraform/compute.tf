data "yandex_compute_image" "ubuntu" {
  family = var.vm_image_family
}

resource "yandex_compute_instance" "vm" {
  name        = "${var.name_prefix}-vm"
  platform_id = var.platform_id
  zone        = var.yc_zone

  resources {
    cores  = var.vm_cores
    memory = var.vm_memory_gb
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = var.boot_disk_size_gb
      type     = var.boot_disk_type
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.this.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.this.id]
  }

  service_account_id = yandex_iam_service_account.vm.id

  metadata = {
    serial-port-enable = "1"
    ssh-keys           = "${var.ssh_user}:${trimspace(var.ssh_public_key)}"
    user-data = templatefile("${path.module}/templates/cloud-init.yaml.tftpl", {
      ssh_user = var.ssh_user
      repo_url = var.repo_url
      repo_ref = var.repo_ref
    })
  }
}
