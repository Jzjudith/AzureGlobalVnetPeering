resource "azurerm_virtual_network" "asiavnet" {
  name                = "asia_vnet"
  location            = var.asia
  resource_group_name = azurerm_resource_group.main.name
  address_space       = ["10.2.0.0/16"]
}

resource "azurerm_subnet" "asiasub" {
  name                 = "asia_subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.asiavnet.name
  address_prefixes     = ["10.2.1.0/24"]
}