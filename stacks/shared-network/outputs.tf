output "resource_group_id" {
  description = "ID-en til den delte ressursgruppa."
  value       = data.azurerm_resource_group.this.id
}

output "resource_group_name" {
  description = "Navnet på den delte ressursgruppa."
  value       = data.azurerm_resource_group.this.name
}

output "location" {
  description = "Azure-regionen."
  value       = data.azurerm_resource_group.this.location
}

output "vnet_id" {
  description = "ID-en til det delte VNet-et."
  value       = data.azurerm_virtual_network.this.id
}

output "vnet_name" {
  description = "Navnet på det delte VNet-et."
  value       = data.azurerm_virtual_network.this.name
}