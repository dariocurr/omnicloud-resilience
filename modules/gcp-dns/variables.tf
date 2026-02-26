variable "project_id" {
  description = "GCP project ID."
  type        = string
}

variable "zone_name" {
  description = "Managed zone name."
  type        = string
}

variable "dns_domain" {
  description = "Root domain (e.g. example.com.). Must end with a dot."
  type        = string
}

variable "record_name" {
  description = "Subdomain for failover record (e.g. www)."
  type        = string
  default     = "www"
}

variable "failover_ttl" {
  description = "TTL for failover record (seconds)."
  type        = number
  default     = 300
}

variable "primary_origin_url" {
  description = "Primary (AWS) origin URL for health check."
  type        = string
}

variable "backup_origin_url" {
  description = "Backup (Azure) origin URL."
  type        = string
}

variable "primary_target_ips" {
  description = "Primary IPs for failover A record."
  type        = list(string)
  default     = []
}

variable "backup_target_ips" {
  description = "Backup IPs for failover A record."
  type        = list(string)
  default     = []
}

variable "health_check_interval_sec" {
  description = "Health check interval (seconds)."
  type        = number
  default     = 30
}

variable "health_check_timeout_sec" {
  description = "Health check timeout (seconds)."
  type        = number
  default     = 5
}
