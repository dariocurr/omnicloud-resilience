# Root outputs

output "aws_cloudfront_domain" {
  description = "CloudFront domain (use for CNAME)."
  value       = module.aws_cdn.cloudfront_domain_name
}

output "aws_cloudfront_url" {
  description = "Primary (AWS) static site URL."
  value       = module.aws_cdn.origin_url
}

output "aws_s3_bucket_id" {
  description = "S3 bucket ID for static hosting."
  value       = module.aws_cdn.bucket_id
}

output "azure_primary_web_endpoint" {
  description = "Azure static website endpoint (backup origin)."
  value       = module.azure_storage.primary_web_endpoint
}

output "azure_storage_account_name" {
  description = "Azure Storage account name."
  value       = module.azure_storage.storage_account_name
}

output "gcp_dns_zone_name_servers" {
  description = "Delegate your domain to these name servers."
  value       = module.gcp_dns.name_servers
}

output "gcp_dns_failover_fqdn" {
  description = "FQDN of the failover record."
  value       = module.gcp_dns.failover_record_fqdn
}
