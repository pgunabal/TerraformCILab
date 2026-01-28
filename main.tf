terraform {
  required_version = ">=1.3.0"
  required_providers {
    azurerm = {
      "source" = "hashicorp/azurerm"
      version  = "3.43.0"
    }
  }

  cloud {
    organization = "PANW-PG"

    workspaces {
      name = "TerraformCILab"
    }
  }

}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

resource "random_string" "uniquestring" {
  length  = 20
  special = false
  upper   = false
}

resource "azurerm_resource_group" "rg" {
  name     = "811-3fe70176-provide-continuous-delivery-with-gith"
  location = "southcentralus"
  tags = {
    yor_trace = "fed7eb7c-3408-4549-ba9f-7a8d44c3a8c7"
  }
}

resource "azurerm_storage_account" "storageaccount" {
  name                     = "stg${random_string.uniquestring.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags = {
    yor_trace = "eaba4b89-7b11-41e2-bcdf-3fcb312591c2"
  }
}
