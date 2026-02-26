locals {
  sanitized_prefix = replace(lower(var.name_prefix), "-", "")
  account_name     = substr("${local.sanitized_prefix}static", 0, 24)
}
