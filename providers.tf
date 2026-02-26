provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile

  default_tags {
    tags = local.common_tags
  }
}

provider "azurerm" {
  features {}
}

provider "google" {
  project = var.gcp_project_id
}
