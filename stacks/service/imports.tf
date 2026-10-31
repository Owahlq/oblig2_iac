locals {
  service_subnet_id = "${local.shared_network.resource_group_id}/providers/Microsoft.Network/virtualNetworks/${local.shared_network.vnet_name}/subnets/snet-${var.service}"

  service_nsg_id = "${local.shared_network.resource_group_id}/providers/Microsoft.Network/networkSecurityGroups/nsg-${var.service}"

  service_storage_account_id = "${local.shared_network.resource_group_id}/providers/Microsoft.Storage/storageAccounts/st${var.kortnavn}${var.service}${var.miljo}"

  service_key_vault_id = "${local.shared_network.resource_group_id}/providers/Microsoft.KeyVault/vaults/kv-${var.kortnavn}-${var.service}-${var.miljo}"

  service_public_ip_id = "${local.shared_network.resource_group_id}/providers/Microsoft.Network/publicIPAddresses/pip-${var.service}"

  service_network_interface_id = "${local.shared_network.resource_group_id}/providers/Microsoft.Network/networkInterfaces/nic-${var.service}"

  service_virtual_machine_id = "${local.shared_network.resource_group_id}/providers/Microsoft.Compute/virtualMachines/vm-${var.service}"

  service_plan_id = "${local.shared_network.resource_group_id}/providers/Microsoft.Web/serverFarms/asp-${var.service}"

  service_web_app_id = "${local.shared_network.resource_group_id}/providers/Microsoft.Web/sites/app-${var.kortnavn}-${var.service}-${var.miljo}"
}

# Network resources

import {
  to = module.subnet.azurerm_subnet.this
  id = local.service_subnet_id
}

import {
  to = module.subnet.azurerm_network_security_group.this
  id = local.service_nsg_id
}

import {
  to = module.subnet.azurerm_network_security_rule.http
  id = "${local.service_nsg_id}/securityRules/allow-http"
}

import {
  to = module.subnet.azurerm_subnet_network_security_group_association.this
  id = local.service_subnet_id
}

# Data resources

import {
  to = module.storage.azurerm_storage_account.this
  id = local.service_storage_account_id
}

import {
  to = module.keyvault.azurerm_key_vault.this
  id = local.service_key_vault_id
}

# VM resources - only for VM-based services

import {
  for_each = var.runtime == "vm" ? toset(["vm"]) : toset([])
  to       = module.vm[0].azurerm_public_ip.this
  id       = local.service_public_ip_id
}

import {
  for_each = var.runtime == "vm" ? toset(["vm"]) : toset([])
  to       = module.vm[0].azurerm_network_interface.this
  id       = local.service_network_interface_id
}

import {
  for_each = var.runtime == "vm" ? toset(["vm"]) : toset([])
  to       = module.vm[0].azurerm_linux_virtual_machine.this
  id       = local.service_virtual_machine_id
}

# Web App resources - only for webapp-based services

import {
  for_each = var.runtime == "webapp" ? toset(["webapp"]) : toset([])
  to       = module.webapp[0].azurerm_service_plan.this
  id       = local.service_plan_id
}

import {
  for_each = var.runtime == "webapp" ? toset(["webapp"]) : toset([])
  to       = module.webapp[0].azurerm_linux_web_app.this
  id       = local.service_web_app_id
}