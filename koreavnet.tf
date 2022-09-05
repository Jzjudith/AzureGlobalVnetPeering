resource "azurerm_virtual_network" "koreavnet" {
  name                = "korea_vnet"
  location            = var.korea
  resource_group_name = azurerm_resource_group.main.name
  address_space       = ["10.2.0.0/16"]
}

resource "azurerm_subnet" "koreasub" {
  name                 = "korea_subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.koreavnet.name
  address_prefixes     = ["10.2.1.0/24"]
}