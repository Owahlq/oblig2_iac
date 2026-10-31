data "azurerm_client_config" "current" {}

data "terraform_remote_state" "shared_network" {
  backend = "azurerm"

  config = {
    resource_group_name  = var.state_resource_group_name
    storage_account_name = var.state_storage_account_name
    container_name       = var.state_container_name
    key                  = "oblig2/${var.miljo}/shared-network.tfstate"
    use_azuread_auth     = true
  }
}

locals {
  shared_network = data.terraform_remote_state.shared_network.outputs

  tags = {
    eier  = var.kortnavn
    miljo = var.miljo
    kurs  = "dcst3005-oblig2"
  }
}

module "subnet" {
  source = "../../modules/subnet"

  service             = var.service
  resource_group_name = local.shared_network.resource_group_name
  location            = local.shared_network.location
  vnet_name           = local.shared_network.vnet_name
  prefix              = var.prefix
  delegate_web        = var.runtime == "webapp"
  allow_http_from     = var.allow_http_from
  extra_tcp_rules     = var.extra_tcp_rules
  tags                = local.tags
}

module "storage" {
  source = "../../modules/storage"

  service             = var.service
  kortnavn            = var.kortnavn
  miljo               = var.miljo
  resource_group_name = local.shared_network.resource_group_name
  location            = local.shared_network.location
  tags                = local.tags
}

module "keyvault" {
  source = "../../modules/keyvault"

  service             = var.service
  kortnavn            = var.kortnavn
  miljo               = var.miljo
  resource_group_name = local.shared_network.resource_group_name
  location            = local.shared_network.location
  tenant_id           = data.azurerm_client_config.current.tenant_id
  tags                = local.tags
}

module "vm" {
  count  = var.runtime == "vm" ? 1 : 0
  source = "../../modules/vm"

  service             = var.service
  resource_group_name = local.shared_network.resource_group_name
  location            = local.shared_network.location
  subnet_id           = module.subnet.subnet_id
  size                = var.vm_size
  ssh_public_key      = var.ssh_public_key
  tags                = local.tags
}

module "webapp" {
  count  = var.runtime == "webapp" ? 1 : 0
  source = "../../modules/webapp"

  service             = var.service
  kortnavn            = var.kortnavn
  miljo               = var.miljo
  resource_group_name = local.shared_network.resource_group_name
  location            = local.shared_network.location
  subnet_id           = module.subnet.subnet_id
  sku                 = var.webapp_sku
  tags                = local.tags
}