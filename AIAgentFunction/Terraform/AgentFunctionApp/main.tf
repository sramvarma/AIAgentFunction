# main.tf

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
        }
        }
        backend "azurerm" {
        resource_group_name  = "rg-terraform-state"
        storage_account_name = "sttfstaterams001"  # update this
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
     }
  }
provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Storage Account (required for Function App)
resource "azurerm_storage_account" "storageaccountramvar" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# App Service Plan (Windows)
resource "azurerm_service_plan" "aspramvar" {
  name                = var.app_service_plan_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Windows"
  sku_name            = "Y1"  # Consumption plan; change to "EP1" for Premium
}

# Windows Function App
resource "azurerm_windows_function_app" "func" {
  name                       = var.function_app_name
  resource_group_name        = azurerm_resource_group.rg.name
  location                   = azurerm_resource_group.rg.location
  storage_account_name       = azurerm_storage_account.storageaccountramvar.name
  storage_account_access_key = azurerm_storage_account.storageaccountramvar.primary_access_key
  service_plan_id            = azurerm_service_plan.aspramvar.id

  site_config {
    application_stack {
      dotnet_version              = "v10.0"
      use_dotnet_isolated_runtime = true
    }
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"   # Run from package (zip deploy)
    "FUNCTIONS_WORKER_RUNTIME" = "dotnet-isolated"
  }

  identity {
    type = "SystemAssigned"
  }
}