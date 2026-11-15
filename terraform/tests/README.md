# Tests

## What’s here

- **`validate.sh`** – Runs `terraform init -backend=false` and `terraform validate`. No cloud credentials required. Run from the `terraform/` directory: `./tests/validate.sh`.

## CI

Validation runs in GitHub Actions on push and pull requests (see `.github/workflows/terraform.yml` at the repo root).

## Going further

- **Plan (needs credentials):** From repo root, with AWS/Azure/GCP configured and a `terraform.tfvars` (or env vars), run `terraform init && terraform plan -input=false` to check for plan-time errors.
- **Integration tests:** For apply/destroy and output checks, use [Terratest](https://terratest.gruntwork.io/) (Go) or [tftest](https://github.com/GoogleCloudPlatform/terraform-python-testing-helper) (Python). Add those under `tests/` (e.g. `tests/terratest/`) and run them in CI with cloud credentials if desired.
