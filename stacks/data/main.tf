# Release the existing storage accounts and Key Vaults from the
# old data stack without destroying the Azure resources.
#
# The generic service stack will import these resources into
# separate Terraform states for each service.

removed {
  from = module.storage

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.keyvault

  lifecycle {
    destroy = false
  }
}