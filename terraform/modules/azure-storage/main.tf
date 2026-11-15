resource "azurerm_resource_group" "rg" {
  name     = "${var.name_prefix}-static-rg"
  location = var.location
  tags     = var.tags
}

resource "azurerm_storage_account" "static" {
  name                     = local.account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication
  min_tls_version          = "TLS1_2"
  tags                     = var.tags
}

# Wait for storage account and blob service to be ready (avoids 404 on read)
resource "time_sleep" "wait_for_storage" {
  create_duration = "45s"
  depends_on      = [azurerm_storage_account.static]
}

# Static website enabled via Azure CLI (inline static_website block is deprecated in azurerm)
resource "null_resource" "static_website" {
  triggers = {
    account_id         = azurerm_storage_account.static.id
    index_document     = var.index_document
    error_404_document = var.error_404_document
  }

  provisioner "local-exec" {
    command = <<-EOT
      az storage blob service-properties update \
        --account-name ${azurerm_storage_account.static.name} \
        --static-website \
        --index-document ${var.index_document} \
        --404-document ${var.error_404_document}
    EOT
    interpreter = ["bash", "-c"]
  }
  depends_on = [time_sleep.wait_for_storage]
}

# Re-read account so primary_web_* are set after static website is enabled
data "azurerm_storage_account" "static" {
  name                = azurerm_storage_account.static.name
  resource_group_name = azurerm_storage_account.static.resource_group_name
  depends_on          = [null_resource.static_website]
}
