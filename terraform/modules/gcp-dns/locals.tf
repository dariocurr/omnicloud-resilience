locals {
  primary_host           = try(split("/", replace(var.primary_origin_url, "https://", ""))[0], replace(var.primary_origin_url, "https://", ""))
  enable_failover_record = length(var.primary_target_ips) > 0 && length(var.backup_target_ips) > 0
}
