provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_compute_backend_service" "backend_service" {
  name        = var.backend_service_name
  protocol    = "HTTP"
  port_name   = "http"
  timeout_sec = 30

  backend {
    group = google_compute_instance_group.backend_instances.self_link
  }

  health_checks = [google_compute_health_check.health_check.self_link]
}

resource "google_compute_health_check" "health_check" {
  name               = var.health_check_name
  check_interval_sec = 5
  timeout_sec        = 5
  tcp_health_check {
    port = 80
  }
}

resource "google_compute_instance_group" "backend_instances" {
  name        = var.backend_instance_group
  description = "Instance group for load balancer backend"

  instances = []  # Add instance IDs or URLs of your backend instances here
}

resource "google_compute_region_backend_service" "region_backend_service" {
  name          = var.backend_service_name
  backend_service = google_compute_backend_service.backend_service.self_link
  region        = var.region
}

resource "google_compute_global_address" "load_balancer_address" {
  name = var.load_balancer_name
  address_type = "EXTERNAL"
}

resource "google_compute_global_forwarding_rule" "forwarding_rule" {
  name       = var.load_balancer_name
  target     = google_compute_region_backend_service.region_backend_service.self_link
  port_range = "80"
  ip_address = google_compute_global_address.load_balancer_address.address
}

output "load_balancer_ip" {
  value = google_compute_global_address.load_balancer_address.address
}
