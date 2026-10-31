# The original network stack temporarily retains ownership of the
# shared resource group and VNet during the migration.

locals {
  tags = {
    eier  = var.kortnavn
    miljo = var.miljo
    kurs  = "dcst3005-oblig2"
  }
}

resource "azurerm_resource_group" "this" {
  name     = "rg-${var.kortnavn}-oblig2-${var.miljo}"
  location = var.location
  tags     = local.tags
}

module "vnet" {
  source              = "../../modules/vnet"
  name                = "vnet-${var.kortnavn}-${var.miljo}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  address_space       = var.address_space
  tags                = local.tags
}

# Release all service-specific network resources from the old state.
# The resources remain in Azure and will be imported into the
# individual service states.

removed {
  from = module.subnet

  lifecycle {
    destroy = false
  }
}