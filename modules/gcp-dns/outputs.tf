output "zone_id" {
  description = "Managed zone ID."
  value       = google_dns_managed_zone.zone.id
}

output "zone_name" {
  description = "Managed zone name."
  value       = google_dns_managed_zone.zone.name
}

output "dns_name" {
  description = "Zone DNS name."
  value       = google_dns_managed_zone.zone.dns_name
}

output "name_servers" {
  description = "Name servers for domain delegation."
  value       = google_dns_managed_zone.zone.name_servers
}

output "failover_record_fqdn" {
  description = "FQDN of the failover record (A or CNAME)."
  value       = local.enable_failover_record ? google_dns_record_set.failover[0].name : google_dns_record_set.primary_cname[0].name
}
