# enable global peering between central us and europ
resource "azurerm_virtual_network_peering" "centeurope" {

  name                      = "centralteurope"
  resource_group_name       = azurerm_resource_group.main.name
  virtual_network_name      = azurerm_virtual_network.centusvnet.name
  remote_virtual_network_id = azurerm_virtual_network.europevnet.id
  allow_forwarded_traffic   = true

  # `allow_gateway_transit` must be set to false for vnet Global Peering
  allow_gateway_transit = false
}

# enable global peering between europe and central us
resource "azurerm_virtual_network_peering" "europecent" {

  name                         = "europetocentral"
  resource_group_name          = azurerm_resource_group.main.name
  virtual_network_name         = azurerm_virtual_network.europevnet.name
  remote_virtual_network_id    = azurerm_virtual_network.centusvnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true

  # `allow_gateway_transit` must be set to false for vnet Global Peering
  allow_gateway_transit = false
}