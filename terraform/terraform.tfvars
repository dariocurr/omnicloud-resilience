# ------------------------------------------------------------------------------
# Example variable values. Copy to terraform.tfvars and adjust.
# ------------------------------------------------------------------------------

project_name = "omnicloud-resilience"
environment  = "dev"

aws_profile    = "dariocurr"
aws_region     = "us-east-1"
azure_location = "Spain Central"

gcp_project_id    = "omnicloud-resilience"
gcp_dns_zone_name = "failover-zone"
gcp_dns_domain    = "example.com."

# Optional: enable health-check steered A record (provide IPs for AWS and Azure origins)
# gcp_dns_primary_target_ips = ["52.84.1.1"]
# gcp_dns_backup_target_ips   = ["20.150.1.1"]
