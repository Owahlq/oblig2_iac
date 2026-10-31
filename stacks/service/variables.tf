variable "kortnavn" {
  description = "Short project identifier used in resource names."
  type        = string
}

variable "miljo" {
  description = "Deployment environment."
  type        = string
}

variable "state_resource_group_name" {
  description = "Resource group containing Terraform state."
  type        = string
}

variable "state_storage_account_name" {
  description = "Storage account containing Terraform state."
  type        = string
}

variable "state_container_name" {
  description = "Blob container containing Terraform state."
  type        = string
}

variable "service" {
  description = "Name of the service instance."
  type        = string
}

variable "runtime" {
  description = "Runtime type used by the service."
  type        = string

  validation {
    condition     = contains(["vm", "webapp"], var.runtime)
    error_message = "The runtime must be vm or webapp."
  }
}

variable "prefix" {
  description = "Address range assigned to the service subnet."
  type        = string
}

variable "ssh_public_key" {
  description = "Public SSH key used by VM-based services."
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGMQ32gu8mGVI86gkUex5JsBeg7WC58bsUOVuxmeHDJW oblig2-ingen-privat-nokkel"
}

variable "allow_http_from" {
  description = "Source address range allowed to access HTTP."
  type        = string
  default     = "Internet"
}

variable "vm_size" {
  description = "Azure virtual machine size."
  type        = string
  default     = "Standard_B2als_v2"
}

variable "webapp_sku" {
  description = "App Service plan SKU."
  type        = string
  default     = "B1"
}

variable "extra_tcp_rules" {
  description = "Additional inbound TCP rules for the service."
  type = map(object({
    port        = number
    source_cidr = string
    priority    = number
  }))
  default = {}
}