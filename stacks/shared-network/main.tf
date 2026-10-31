data "azurerm_resource_group" "this" {
  name = "rg-${var.kortnavn}-oblig2-${var.miljo}"
}

data "azurerm_virtual_network" "this" {
  name                = "vnet-${var.kortnavn}-${var.miljo}"
  resource_group_name = data.azurerm_resource_group.this.name
}