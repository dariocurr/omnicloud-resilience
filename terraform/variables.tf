# Project
variable "project_name" {
  description = "Short project name for resource naming and tags."
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9-]{2,24}$", var.project_name))
    error_message = "project_name must be 2-24 chars, lowercase alphanumeric and hyphens only."
  }
}

variable "environment" {
  description = "Environment: dev, staging, or prod."
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be one of: dev, staging, prod."
  }
}

# AWS
variable "aws_region" {
  description = "AWS region for S3 and CloudFront."
  type        = string
}

variable "aws_profile" {
  description = "AWS CLI profile (from ~/.aws/credentials). Empty = default profile or AWS_PROFILE."
  type        = string
  default     = ""
}

variable "aws_cdn_domain_aliases" {
  description = "Optional CNAMEs for CloudFront (e.g. www.example.com)."
  type        = list(string)
  default     = []
}

variable "aws_cdn_price_class" {
  description = "CloudFront price class (PriceClass_All, PriceClass_200, PriceClass_100)."
  type        = string
  default     = "PriceClass_100"
}

# Azure
variable "azure_location" {
  description = "Azure region (e.g. East US, West Europe)."
  type        = string
}

variable "azure_storage_account_tier" {
  description = "Storage account tier: Standard or Premium."
  type        = string
  default     = "Standard"
}

variable "azure_storage_account_replication" {
  description = "Storage replication (e.g. LRS, GRS)."
  type        = string
  default     = "LRS"
}

# GCP
variable "gcp_project_id" {
  description = "GCP project ID for Cloud DNS."
  type        = string
}

variable "gcp_dns_zone_name" {
  description = "Cloud DNS managed zone name."
  type        = string
}

variable "gcp_dns_domain" {
  description = "Root domain for the zone (e.g. example.com.). Must end with a dot."
  type        = string
}

variable "gcp_dns_record_name" {
  description = "Subdomain for failover record (e.g. www)."
  type        = string
  default     = "www"
}

variable "gcp_dns_failover_ttl" {
  description = "TTL in seconds for the failover record."
  type        = number
  default     = 300
}

variable "gcp_dns_primary_target_ips" {
  description = "Primary (AWS) IPs for health-checked A record. Empty = CNAME only."
  type        = list(string)
  default     = []
}

variable "gcp_dns_backup_target_ips" {
  description = "Backup (Azure) IPs for failover A record."
  type        = list(string)
  default     = []
}

variable "gcp_dns_health_check_interval_sec" {
  description = "Health check interval (seconds)."
  type        = number
  default     = 30
}

variable "gcp_dns_health_check_timeout_sec" {
  description = "Health check timeout (seconds)."
  type        = number
  default     = 5
}
