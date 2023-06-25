# Terraform Cloud Variables
variable ARM_SUBSCRIPTION_ID {}
variable ARM_CLIENT_SECRET {}
variable ARM_CLIENT_ID {}
variable ARM_TENANT_ID {}
variable environment {}
variable organization {}

# Workspace Variables
variable "RGID" {
  type        = string
  description = "Resource Group ID"
}

variable "stakeholder" {
  type        = string
  description = "Creator of resources"
}

variable "location" {
  type        = string
  description = "Location/Region where resources are made"
  default     = "West US"
}

variable "create_date" {
  type        = string
  description = "Creation date of resources MMDDYYYY"
}

variable "name_suffix" {
  type        = string
  description = "Suffix for reosurce names"
  default     = ""
}

# Resource Variables
variable "num" {
  type        = number
  description = "Number of resources"
  default     = 1
}

variable "account_tier" {
  type        = string
  description = "Storage Account tier - Valid options are Standard, Premium"
  default     = "Standard"
}

variable "account_replication_type" {
  type        = string
  description = "Account replication type - Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS"
  default     = "LRS"
}