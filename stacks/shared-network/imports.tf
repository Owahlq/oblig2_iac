# Adopt the existing resource group without recreating it.
import {
  to = azurerm_resource_group.this
  id = data.azurerm_resource_group.this.id
}

# Adopt the existing virtual network without recreating it.
import {
  to = module.vnet.azurerm_virtual_network.this
  id = data.azurerm_virtual_network.this.id
}