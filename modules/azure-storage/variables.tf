variable "name_prefix" {
  description = "Prefix for resource names (e.g. project-environment)."
  type        = string
}

variable "tags" {
  description = "Map of tags to apply to supported resources."
  type        = map(string)
  default     = {}
}

variable "location" {
  description = "Azure region (e.g. East US, West Europe)."
  type        = string
}

variable "account_tier" {
  description = "Storage account tier: Standard or Premium."
  type        = string
  default     = "Standard"
}

variable "account_replication" {
  description = "Storage account replication (e.g. LRS, GRS)."
  type        = string
  default     = "LRS"
}

variable "index_document" {
  description = "Name of the index document for static website."
  type        = string
  default     = "index.html"
}

variable "error_404_document" {
  description = "Name of the 404 error document for static website."
  type        = string
  default     = "404.html"
}
