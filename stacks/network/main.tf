# Release the shared resource group from the old network state.
removed {
  from = azurerm_resource_group.this

  lifecycle {
    destroy = false
  }
}

# Release the shared VNet from the old network state.
removed {
  from = module.vnet

  lifecycle {
    destroy = false
  }
}

# Retain the earlier subnet release declaration until cleanup.
removed {
  from = module.subnet

  lifecycle {
    destroy = false
  }
}