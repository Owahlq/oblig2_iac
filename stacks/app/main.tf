# Release the existing VM and Web App resources from the
# old application stack without destroying them in Azure.
#
# The generic service stack will import these resources.

removed {
  from = module.vm

  lifecycle {
    destroy = false
  }
}

removed {
  from = module.webapp

  lifecycle {
    destroy = false
  }
}