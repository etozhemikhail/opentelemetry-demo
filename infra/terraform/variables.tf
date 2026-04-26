variable "yc_token" {
  description = "Yandex Cloud IAM token. Prefer TF_VAR_yc_token env var."
  type        = string
  sensitive   = true
  default     = null
}

variable "yc_cloud_id" {
  description = "Yandex Cloud ID."
  type        = string
}

variable "yc_folder_id" {
  description = "Yandex Cloud Folder ID."
  type        = string
}

variable "yc_zone" {
  description = "Availability zone for VM and subnet."
  type        = string
  default     = "ru-central1-a"
}

variable "name_prefix" {
  description = "Name prefix for all created resources."
  type        = string
  default     = "otel-demo"
}

variable "subnet_cidr_blocks" {
  description = "CIDR blocks for the subnet."
  type        = list(string)
  default     = ["10.10.0.0/24"]
}

variable "allowed_cidrs" {
  description = "CIDR list allowed for SSH and UI access."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "platform_id" {
  description = "YC VM platform ID."
  type        = string
  default     = "standard-v3"
}

variable "vm_cores" {
  description = "Number of vCPUs for demo VM."
  type        = number
  default     = 8
}

variable "vm_memory_gb" {
  description = "Memory size in GB for demo VM."
  type        = number
  default     = 16
}

variable "boot_disk_size_gb" {
  description = "Boot disk size in GB."
  type        = number
  default     = 120
}

variable "boot_disk_type" {
  description = "Boot disk type."
  type        = string
  default     = "network-ssd"
}

variable "vm_image_family" {
  description = "Image family used for VM."
  type        = string
  default     = "ubuntu-2204-lts"
}

variable "ssh_user" {
  description = "Linux username for SSH access."
  type        = string
  default     = "ubuntu"
}

variable "ssh_public_key" {
  description = "SSH public key content."
  type        = string
}

variable "repo_url" {
  description = "Git repository URL with opentelemetry-demo sources."
  type        = string
  default     = "https://github.com/open-telemetry/opentelemetry-demo.git"
}

variable "repo_ref" {
  description = "Git branch/tag/commit to checkout."
  type        = string
  default     = "main"
}

variable "frontend_proxy_port" {
  description = "Public frontend proxy port from .env."
  type        = number
  default     = 8080
}

variable "grafana_port" {
  description = "Grafana port from .env."
  type        = number
  default     = 3000
}

variable "jaeger_ui_port" {
  description = "Jaeger UI port from .env."
  type        = number
  default     = 16686
}

variable "additional_ingress_ports" {
  description = "Optional extra TCP ingress ports to expose."
  type        = list(number)
  default     = [10000]
}
