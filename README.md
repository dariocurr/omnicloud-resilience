# Multi-Cloud Global Failover (Terraform)

Personal project. **Goal:** keep static content highly available across
clouds—serve from AWS (primary) and Azure (backup), with GCP Cloud DNS steering
traffic and failing over to the backup when the primary is unhealthy, so users
always get a response even if one provider has an outage.

- **AWS:** S3 static hosting behind CloudFront with **Origin Access Control
  (OAC)**
- **Azure:** Storage Account with static website hosting as **backup origin**
- **GCP:** Cloud DNS with **health-check steered** primary/backup routing (AWS →
  Azure)

## Folder structure

```text
.
├── main.tf                 # Root module: calls aws-cdn, azure-storage, gcp-dns
├── variables.tf            # Root variables (descriptions + type constraints)
├── outputs.tf              # Root outputs
├── providers.tf            # AWS, Azure, GCP providers
├── versions.tf             # required_version + required_providers
├── locals.tf               # Naming convention (name_prefix, common_tags)
├── checks.tf               # Check block: origin URLs non-empty for DNS
├── terraform.tfvars
├── Troubleshooting.md      # State lock and resource drift
├── modules/
│   ├── aws-cdn/            # S3 + CloudFront (OAC)
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── locals.tf
│   ├── azure-storage/      # Storage Account static website
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── locals.tf
│   └── gcp-dns/            # Cloud DNS + health-check steered failover
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── locals.tf
├── tests/
│   ├── validate.sh         # init + validate (no credentials)
│   └── README.md
├── .github/workflows/
│   └── terraform.yml       # CI: validate on push/PR
└── README.md
```

## Testing

- **Local:** From the repo root run `./tests/validate.sh`
  (Terraform init + validate; no cloud credentials).
- **CI:** GitHub Actions runs the same validate on push and pull requests to
  `main`. See `tests/README.md` for more options (plan, Terratest).

## Prerequisites

- Terraform >= 1.5
- AWS, Azure, and GCP credentials configured (env vars or provider config)

## Quick start

1. Set variables in `terraform.tfvars` (project_name, environment, regions, gcp_project_id, gcp_dns_domain, etc.).

2. Plan and apply:

   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

3. Delegate your domain to the GCP zone name servers (see output
   `gcp_dns_zone_name_servers`).

## Practices in this repo

- **Modular layout:** Separate modules for `aws-cdn`, `azure-storage`, and
  `gcp-dns`.
- **Variables/outputs only:** No hardcoded strings; types and descriptions in
  `variables.tf`.
- **required_providers**, **locals** for naming and tags.
- **Preconditions** in the GCP module so AWS and Azure origin URLs are
  non-empty before creating the health check and failover record.
- **Check block** in the root module to ensure origin URLs are set after apply.

## Failover behavior

- **Without** `gcp_dns_primary_target_ips` / `gcp_dns_backup_target_ips`: A
  CNAME is created to the primary (CloudFront).
- **With** both IP lists set: An A record with health-check steered
  primary/backup is created (primary = AWS IPs, backup = Azure IPs).
  CloudFront/Azure IPs can be resolved externally and passed in.

See [Troubleshooting.md](Troubleshooting.md) for state lock and resource drift
(e.g. S3 bucket manually deleted).
