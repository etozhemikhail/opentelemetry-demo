resource "yandex_iam_service_account" "vm" {
  name        = "${var.name_prefix}-vm-sa"
  description = "Service account attached to opentelemetry-demo VM."
}

resource "yandex_resourcemanager_folder_iam_member" "vm_logging" {
  folder_id = var.yc_folder_id
  role      = "logging.writer"
  member    = "serviceAccount:${yandex_iam_service_account.vm.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "vm_monitoring" {
  folder_id = var.yc_folder_id
  role      = "monitoring.editor"
  member    = "serviceAccount:${yandex_iam_service_account.vm.id}"
}
