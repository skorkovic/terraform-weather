provider "azurerm" {
    features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.96.0"
    }
  }
}

resource "azurerm_resource_group" "tf_test" {
    name = "tfmainrg"
    location = "westeurope"
}

resource "azurerm_container_group" "tfcg_test" {
    name = "weatherapi"
    location = azurerm_resource_group.tf_test.location
    resource_group_name = azurerm_resource_group.tf_test.name

    ip_address_type = "Public"
    dns_name_label = "binarythistleprodyna"
    os_type = "Linux"

    container {
        name = "weatherapi"
        image = "skorkovic/weatherapi"
        cpu = "1"
        memory = "1"

        ports {
            port = 80
            protocol = "TCP"
        }
    }
}