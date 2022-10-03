#############################################################################
# PROVIDERS
#############################################################################

# terraform {
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "~>3.18"
#     }
#     # random = {
#     #   source  = "hashicorp/random"
#     #   version = "~>3.1"
#     # }
#   }
# }


# provider "azurerm" {
#   features {}
# }

# provider "azurerm" {
#   alias           = "HUB"
#   subscription_id = var.HUB_SUBSCRIPTION
#   tenant_id       = var.HUB_TENANTID
#   client_id       = var.HUB_CLIENTID
#   client_secret   = var.HUB_CLIENTSECRET
#   features {}
# }

# provider "random" {
# }


#############################################################################
# RESOURCES
#############################################################################

resource "azurerm_storage_account" "stg" {
  name                = var.STG_NAME
  resource_group_name = var.RESOURCE_GROUP

  location                 = var.LOCATION
  account_tier             = var.TIER
  account_replication_type = var.REPLICATION
  public_network_access_enabled = var.PUBLIC_ACCESS

  network_rules {
    default_action             = var.NETWORK_ACTION
    ip_rules                   = var.ALLOW_IP_LIST
    virtual_network_subnet_ids = var.ALLOW_VNET_LIST
  }

  tags = var.TAGS
}