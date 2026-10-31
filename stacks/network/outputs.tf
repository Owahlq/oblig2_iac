output "resource_group_name" {
  description = "Name of the shared resource group."
  value       = azurerm_resource_group.this.name
}

output "location" {
  description = "Azure region of the shared infrastructure."
  value       = azurerm_resource_group.this.location
}

output "vnet_name" {
  description = "Name of the shared virtual network."
  value       = module.vnet.name
}