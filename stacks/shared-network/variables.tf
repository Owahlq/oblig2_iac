variable "kortnavn" {
  description = "Kortnavnet ditt."
  type        = string
}

variable "miljo" {
  description = "Miljøet. Settes av scripts/kjor.sh."
  type        = string

  validation {
    condition     = contains(["dev", "prod"], var.miljo)
    error_message = "miljo må være dev eller prod."
  }
}