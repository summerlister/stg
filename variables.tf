variable "STG_NAME" {
  description = ""
}
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