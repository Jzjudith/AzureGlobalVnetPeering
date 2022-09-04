resource "azurerm_resource_group" "main" {
  name     = "centus-rg"
  location = var.centralus
}

resource "azurerm_virtual_network" "centusvnet" {
  name                = "centralus_vnet"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_subnet" "centus_gateway" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.centusvnet.name
  address_prefixes     = ["10.1.1.0/24"]
}

resource "azurerm_subnet" "mgmt_subnet" {
  name                 = "MgmtSubnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.centusvnet.name
  address_prefixes     = ["10.1.2.0/24"]
}

resource "azurerm_public_ip" "centus" {
  name                = "centuspip"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Dynamic"
}

resource "azurerm_public_ip" "mgmt" {
  name                = "mgmtpip"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
}
resource "azurerm_virtual_network_gateway" "centus" {
  name                = "us-gateway"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  type     = "Vpn"
  vpn_type = "RouteBased"
  sku      = "Basic"

  ip_configuration {
    public_ip_address_id          = azurerm_public_ip.centus.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.centus_gateway.id
  }
}



