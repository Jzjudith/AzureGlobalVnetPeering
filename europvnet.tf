resource "azurerm_virtual_network" "europevnet" {
  name                = "europe_vnet"
  location            = var.europe
  resource_group_name = azurerm_resource_group.main.name
  address_space       = ["10.3.0.0/16"]
}

resource "azurerm_subnet" "europesub" {
  name                 = "europe_subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.europevnet.name
  address_prefixes     = ["10.3.1.0/24"]
}