# Zone
resource "google_dns_managed_zone" "zone" {
  name        = var.zone_name
  dns_name    = var.dns_domain
  description = "Multi-cloud failover"
  project     = var.project_id
}

# Health check for primary (AWS) origin
resource "google_compute_health_check" "primary" {
  project             = var.project_id
  name                = "${var.zone_name}-primary-origin"
  description         = "Primary (AWS) origin"
  check_interval_sec  = var.health_check_interval_sec
  timeout_sec         = var.health_check_timeout_sec
  healthy_threshold   = 2
  unhealthy_threshold = 3

  https_health_check {
    port               = 443
    port_specification = "USE_FIXED_PORT"
    request_path       = "/"
    proxy_header       = "NONE"
    host               = local.primary_host
  }

  lifecycle {
    precondition {
      condition     = length(trimspace(var.primary_origin_url)) > 0
      error_message = "primary_origin_url must not be empty."
    }
  }
}

# A record with health-check steered failover (when primary/backup IPs are set)
resource "google_dns_record_set" "failover" {
  count = local.enable_failover_record ? 1 : 0

  name         = "${var.record_name}.${google_dns_managed_zone.zone.dns_name}"
  type         = "A"
  ttl          = var.failover_ttl
  managed_zone = google_dns_managed_zone.zone.name
  project      = var.project_id

  routing_policy {
    health_check = google_compute_health_check.primary.id
    primary_backup {
      trickle_ratio = 0.1
      primary {
        external_endpoints = var.primary_target_ips
      }
      backup_geo {
        location = "us-central1"
        rrdatas  = var.backup_target_ips
      }
    }
  }

  lifecycle {
    precondition {
      condition     = length(trimspace(var.backup_origin_url)) > 0
      error_message = "backup_origin_url must not be empty."
    }
  }
}

# CNAME to primary when not using IP-based failover
resource "google_dns_record_set" "primary_cname" {
  count = local.enable_failover_record ? 0 : 1

  name         = "${var.record_name}.${google_dns_managed_zone.zone.dns_name}"
  type         = "CNAME"
  ttl          = var.failover_ttl
  managed_zone = google_dns_managed_zone.zone.name
  project      = var.project_id
  rrdatas      = ["${local.primary_host}."]
}
