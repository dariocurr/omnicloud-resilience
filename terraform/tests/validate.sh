#!/usr/bin/env bash
# Run from repo root: ./tests/validate.sh
# Requires Terraform >= 1.5. No cloud credentials needed for validate.

set -e
cd "$(dirname "$0")/.."

echo "==> Terraform init (no backend)..."
terraform init -backend=false -input=false

echo "==> Terraform validate..."
terraform validate

echo "==> OK: validate passed"
