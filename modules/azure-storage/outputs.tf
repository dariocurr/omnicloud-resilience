output "storage_account_name" {
  description = "Storage account name."
  value       = azurerm_storage_account.static.name
}

output "storage_account_id" {
  description = "Storage account resource ID."
  value       = azurerm_storage_account.static.id
}

output "primary_web_endpoint" {
  description = "Static website HTTPS endpoint."
  value       = "https://${data.azurerm_storage_account.static.primary_web_host}"
}

output "primary_web_host" {
  description = "Static website hostname."
  value       = data.azurerm_storage_account.static.primary_web_host
}

output "resource_group_name" {
  description = "Resource group name."
  value       = azurerm_resource_group.rg.name
}
