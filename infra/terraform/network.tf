locals {
  ingress_ports = distinct(concat(
    [
      var.frontend_proxy_port,
      var.grafana_port,
      var.jaeger_ui_port,
      22
    ],
    var.additional_ingress_ports
  ))
}

resource "yandex_vpc_network" "this" {
  name = "${var.name_prefix}-network"
}

resource "yandex_vpc_subnet" "this" {
  name           = "${var.name_prefix}-subnet"
  zone           = var.yc_zone
  network_id     = yandex_vpc_network.this.id
  v4_cidr_blocks = var.subnet_cidr_blocks
}

resource "yandex_vpc_security_group" "this" {
  name       = "${var.name_prefix}-sg"
  network_id = yandex_vpc_network.this.id

  dynamic "ingress" {
    for_each = local.ingress_ports
    content {
      description    = ingress.value == 22 ? "SSH access" : "Demo UI/endpoint access"
      protocol       = "TCP"
      port           = ingress.value
      v4_cidr_blocks = var.allowed_cidrs
    }
  }

  egress {
    description    = "Allow all egress traffic"
    protocol       = "ANY"
    from_port      = 0
    to_port        = 65535
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
