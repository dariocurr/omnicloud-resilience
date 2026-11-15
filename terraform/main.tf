# Multi-cloud failover: AWS (primary) + Azure (backup) + GCP DNS

module "aws_cdn" {
  source = "./modules/aws-cdn"

  name_prefix    = local.name_prefix
  tags           = local.common_tags
  region         = var.aws_region
  domain_aliases = var.aws_cdn_domain_aliases
  price_class    = var.aws_cdn_price_class
}

module "azure_storage" {
  source = "./modules/azure-storage"

  name_prefix         = local.name_prefix
  tags                = local.common_tags
  location            = var.azure_location
  account_tier        = var.azure_storage_account_tier
  account_replication = var.azure_storage_account_replication
}

module "gcp_dns" {
  source = "./modules/gcp-dns"

  project_id                = var.gcp_project_id
  zone_name                 = var.gcp_dns_zone_name
  dns_domain                = var.gcp_dns_domain
  record_name               = var.gcp_dns_record_name
  failover_ttl              = var.gcp_dns_failover_ttl
  primary_origin_url        = module.aws_cdn.origin_url
  backup_origin_url         = module.azure_storage.primary_web_endpoint
  primary_target_ips        = var.gcp_dns_primary_target_ips
  backup_target_ips         = var.gcp_dns_backup_target_ips
  health_check_interval_sec = var.gcp_dns_health_check_interval_sec
  health_check_timeout_sec  = var.gcp_dns_health_check_timeout_sec

  depends_on = [module.aws_cdn, module.azure_storage]
}
