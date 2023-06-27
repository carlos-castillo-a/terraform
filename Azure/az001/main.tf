# Configure Terraform Cloud & Required Providers
terraform {
  cloud {
    organization = var.organization

    workspaces {
      tags = [var.environment]
    }
  }

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.26.0"
    }
    
    azuread = {
      source = "hashicorp/azuread"
      version = "2.29.0"
    }
  }
}

# Configure the Azure Providers
provider "azurerm" { 
  features {}
  subscription_id = var.ARM_SUBSCRIPTION_ID
  client_id       = var.ARM_CLIENT_ID
  client_secret   = var.ARM_CLIENT_SECRET
  tenant_id       = var.ARM_TENANT_ID
}

provider "azuread" { 
  # Configuration options 
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = format("az%s-%s-rgp-%s%s", var.project, var.environment, var.create_date, var.name_suffix)
  location = var.location
}