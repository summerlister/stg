#############################################################################
# PROVIDERS
#############################################################################

#############################################################################
# DATA
#############################################################################

data "azurerm_subnet" "priv_endpoint_subnet" {
  for_each = toset(var.PRIV_END_SUBNET != null ? [var.PRIV_END_SUBNET] : [])
  name = "${var.ENV}${each.key}"
  virtual_network_name = var.VNET_NAME
  resource_group_name = var.RESOURCE_GROUP
}

#############################################################################
# RESOURCES
#############################################################################

resource "random_string" "random" {
  length = 4
  special = false
  lower = true
}

resource "azurerm_storage_account" "stg" {
  name                = lower( "${var.STG_NAME}${var.ENV}${random_string.random.result}")
  resource_group_name = var.RESOURCE_GROUP

  location                 = var.LOCATION
  account_tier             = var.TIER
  account_replication_type = var.REPLICATION
  enable_https_traffic_only = true
  public_network_access_enabled = var.PUBLIC_ACCESS
  account_kind = var.KIND
  is_hns_enabled = var.HNS

  network_rules {
    default_action             = var.NETWORK_ACTION
    ip_rules                   = var.ALLOW_IP_LIST
    virtual_network_subnet_ids = var.ALLOW_VNET_LIST
  }

  dynamic "blob_properties" {
    for_each = var.KIND == "StorageV2" ? [var.KIND] : []
    content {
      delete_retention_policy {
        days = var.BLOB_RETENTION
      }
      container_delete_retention_policy {
        days = var.BLOB_RETENTION
      }
      versioning_enabled = var.BLOB_VERSIONING
    }
  }

  tags = var.TAGS
}

#############################################################################
# PRIVATE ENDPOINT
#############################################################################

# resource "azurerm_private_endpoint" "privateendpoint_blob" {
#   for_each            = var.KIND == "StorageV2" ? toset(var.PRIV_END_SUBNET != null ? [var.PRIV_END_SUBNET] : []) : toset([])
#   name                = lower("pe-${var.STG_NAME}blob${var.ENV}-${random_string.random.result}")
#   location            = var.LOCATION
#   resource_group_name = var.RESOURCE_GROUP
#   subnet_id           = data.azurerm_subnet.priv_endpoint_subnet[each.key].id

#   private_service_connection {
#     name                           = lower("privsvcconn-${var.STG_NAME}${var.ENV}-${random_string.random.result}")
#     is_manual_connection           = false
#     private_connection_resource_id = azurerm_storage_account.stg_acct.id
#     subresource_names              = ["blob"]
#   }
#   tags = local.TAGS
# }


# #############################################################################
# # PRIVATE DNS
# #############################################################################


# resource "azurerm_private_dns_a_record" "private_endpoint_a_record_blob" {
#   for_each            = var.KIND == "StorageV2" ? toset(var.PRIV_END_SUBNET != null ? [var.PRIV_END_SUBNET] : []) : toset([])
#   name                = azurerm_storage_account.stg_acct.name
#   zone_name           = data.azurerm_private_dns_zone.azurestorageblob.name
#   resource_group_name = var.DNS_RG
#   ttl                 = 10
#   records             = [azurerm_private_endpoint.privateendpoint_blob[each.key].private_service_connection.0.private_ip_address]
# }
