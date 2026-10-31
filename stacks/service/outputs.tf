output "service" {
  description = "Name of the service."
  value       = var.service
}

output "subnet_id" {
  description = "ID of the service subnet."
  value       = module.subnet.subnet_id
}

output "storage_account_name" {
  description = "Name of the service storage account."
  value       = module.storage.name
}

output "key_vault_name" {
  description = "Name of the service Key Vault."
  value       = module.keyvault.name
}

output "vm_public_ip" {
  description = "Public IP of the VM, if this service uses a VM."
  value       = try(module.vm[0].public_ip, null)
}

output "webapp_hostname" {
  description = "Hostname of the web app, if this service uses a web app."
  value       = try(module.webapp[0].hostname, null)
}