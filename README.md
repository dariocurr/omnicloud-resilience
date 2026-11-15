# omnicloud resilience

a comparative study of multi-cloud failover. the same architecture is built twice, once with terraform
and once with pulumi: static content served from aws (s3 + cloudfront) as the primary origin, azure
storage as the backup origin, and gcp cloud dns in front of them. the point is to compare the two
tools on the same job. they don't go equally far: the terraform version can steer traffic with a
health-checked failover record, while the pulumi version only lays out separate primary and backup
records and handles cloudfront teardown ordering explicitly.

## terraform

hcl with a root module that calls three modules (`aws-cdn`, `azure-storage`, `gcp-dns`). cloudfront
uses origin access control, and the gcp module can create a health-check steered primary/backup
record when ip lists are provided (otherwise a plain cname to the primary). validation runs without
cloud credentials.

see [terraform/README.md](terraform/README.md).

## pulumi

python (managed with uv) with one component class per cloud (`AwsInfra`, `AzureInfra`, `GcpInfra`),
typed config loaded from `Pulumi.<stack>.yaml`, and the cloudfront domain passed into the gcp
component as an output. azure soft delete is toggled by a config flag. the unit tests cover the pure
dns and naming helpers only.

see [pulumi/README.md](pulumi/README.md).

## comparison

drawn from the two readmes and the code, not from measurements:

| | terraform | pulumi |
| --- | --- | --- |
| language | hcl | python |
| structure | root module plus `modules/` | component resources under `components/` |
| inputs | `variables.tf` and `terraform.tfvars` | `pulumi.Config()` and `Pulumi.dev.yaml` |
| dns failover | health-check steered a record when ips are given, cname otherwise | separate `www` and `backup` cname records, no health check |
| state | local state first, s3 and dynamodb bootstrap in `backend.tf` | pulumi stack state (no backend configured here) |
| tests | `terraform validate` via `terraform/tests/validate.sh` | pytest on pure helpers |
| ci | [terraform workflow](.github/workflows/terraform.yml) | [pulumi workflow](.github/workflows/pulumi.yml) |

## layout

```text
terraform/   terraform implementation
pulumi/      pulumi implementation
.github/     one workflow per implementation, each filtered to its own directory
```
