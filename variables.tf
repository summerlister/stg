variable "STG_NAME" {
  description = ""
}
variable "ENV" {}

variable "RESOURCE_GROUP" {
  description = ""
}
variable "LOCATION" {
  description = ""
}
variable "TIER" {
  description = ""
}
variable "REPLICATION" {
  description = ""
}
variable "KIND" {
  description = ""
}
variable "HNS" {
  default = false
}
variable "VNET_NAME" {}

variable "PRIV_END_SUBNET" {
  description = ""
}
variable "DNS_RG" {
  description = ""
}
variable "BLOB_VERSIONING" {
  default = true
}
variable "BLOB_RETENTION" {
  default = 7
}
variable "PUBLIC_ACCESS" {
  default = false
}
variable "NETWORK_ACTION" {
  default = "Deny"
  description = ""
}
variable "ALLOW_IP_LIST" {
  default = []
  description = ""
}
variable "ALLOW_VNET_LIST" {
  default = []
  description = ""
}
variable "TAGS" {
  description = ""
}