
resource "azurerm_virtual_network" "eastvnet" {
  name                = "east_vnet"
  location            = var.eastus2
  resource_group_name = azurerm_resource_group.main.name
  address_space       = ["10.4.0.0/16"]
}

resource "azurerm_subnet" "east_gateway" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.eastvnet.name
  address_prefixes     = ["10.4.1.0/24"]
}

resource "azurerm_subnet" "eastus_subnet" {
  name                 = "local_subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.eastvnet.name
  address_prefixes     = ["10.4.2.0/24"]
}
resource "azurerm_public_ip" "eastus" {
  name                = "east_pip"
  location            = var.eastus2
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Dynamic"
}


resource "azurerm_virtual_network_gateway" "east" {
  name                = "east-gateway"
  location            = var.eastus2
  resource_group_name = azurerm_resource_group.main.name

  type     = "Vpn"
  vpn_type = "RouteBased"
  sku      = "Basic"

  ip_configuration {
    public_ip_address_id          = azurerm_public_ip.eastus.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.east_gateway.id
  }
}