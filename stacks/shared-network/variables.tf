variable "kortnavn" {
  description = "Short project identifier."
  type        = string
}

variable "miljo" {
  description = "Deployment environment."
  type        = string

  validation {
    condition     = contains(["dev", "prod"], var.miljo)
    error_message = "miljo must be dev or prod."
  }
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "address_space" {
  description = "Address space of the shared VNet."
  type        = list(string)
}