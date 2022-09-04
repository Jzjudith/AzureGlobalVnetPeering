resource "azurerm_virtual_network_gateway_connection" "centus_to_eastus" {
  name                = "us-to-eastus"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  type                            = "Vnet2Vnet"
  virtual_network_gateway_id      = azurerm_virtual_network_gateway.centus.id
  peer_virtual_network_gateway_id = azurerm_virtual_network_gateway.east.id

  shared_key = "4-v3ry-53cr37-1p53c-5h4r3d-k3y"
}

resource "azurerm_virtual_network_gateway_connection" "eastus_to_centus" {
  name                = "eastuse-to-us"
  location            = var.eastus2
  resource_group_name = azurerm_resource_group.main.name

  type                            = "Vnet2Vnet"
  virtual_network_gateway_id      = azurerm_virtual_network_gateway.east.id
  peer_virtual_network_gateway_id = azurerm_virtual_network_gateway.centus.id

  shared_key = "4-v3ry-53cr37-1p53c-5h4r3d-k3y"
}