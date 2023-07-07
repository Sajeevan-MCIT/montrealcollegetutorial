variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region for load balancer"
  type        = string
}

variable "backend_service_name" {
  description = "Name of the backend service"
  type        = string
}

variable "health_check_name" {
  description = "Name of the health check"
  type        = string
}

variable "backend_instance_group" {
  description = "Name of the instance group for the backend"
  type        = string
}

variable "load_balancer_name" {
  description = "Name of the load balancer"
  type        = string
}

variable "load_balancer_ip" {
  description = "IP address for the load balancer"
  type        = string
}
