terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
  features {}
  
subscription_id = "73467ca4-d2a1-4e9b-a229-bf168d294ff5"
  tenant_id       = "9b13c273-38a4-432a-892e-62afb9c4ec84"
  client_id       = "8760612a-57ae-47ed-afd7-4b5eb5614ef2"
  client_secret   = "7Cu8Q~Yw44wBIYCdNflKLDOyLBs5YDrHlZJg~bZY"
  environment     = "public"  # This specifies the Azure environment, it could be "public", "china", "germany",
  }


resource "azurerm_resource_group" "rg" {
  name     = "sandyterraform"
  location = "eastus"  # Corrected location to "eastus" for US East region
}

resource "azurerm_container_registry" "acr" {
  name                     = "acrsandycluster"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  sku                      = "Basic"
  admin_enabled            = true
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "akssandycluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "akscluster"  # Adjusted the dns_prefix to meet requirements

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
  }

  service_principal {
    client_id       = "8760612a-57ae-47ed-afd7-4b5eb5614ef2"
    client_secret   = "7Cu8Q~Yw44wBIYCdNflKLDOyLBs5YDrHlZJg~bZY"
  }

  
}