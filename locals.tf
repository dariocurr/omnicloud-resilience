locals {
  name_prefix        = "${var.project_name}-${var.environment}"
  backend_bucket     = "aws-${var.project_name}-resilience-${var.environment}"
  backend_lock_table = "terraform-state-lock"
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}
