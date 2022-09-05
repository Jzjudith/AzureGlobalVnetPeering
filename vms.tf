# central us nic
resource "azurerm_network_interface" "nic1" {
  name                = "mgmt-nic"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "pcentus-ipconfig"
    subnet_id                     = azurerm_subnet.mgmt_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.mgmt.id
  }
}

# korea nic
resource "azurerm_network_interface" "nic2" {
  name                = "korea-nic"
  location            = var.korea
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "korea-ipconfig"
    subnet_id                     = azurerm_subnet.koreasub.id
    private_ip_address_allocation = "Dynamic"

  }
}

# europe nic
resource "azurerm_network_interface" "nic3" {
  name                = "europe-nic"
  location            = var.europe
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "europ-ipconfig"
    subnet_id                     = azurerm_subnet.europesub.id
    private_ip_address_allocation = "Dynamic"

  }
}

# east us nic
resource "azurerm_network_interface" "nic4" {
  name                = "eastus-nic"
  location            = var.eastus2
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "public-ipconfig"
    subnet_id                     = azurerm_subnet.eastus_subnet.id
    private_ip_address_allocation = "Dynamic"

  }
}
# central us managemt vm
resource "azurerm_linux_virtual_machine" "mgmt" {
  name                  = "mgmtvm"
  resource_group_name   = azurerm_resource_group.main.name
  location              = azurerm_resource_group.main.location
  size                  = "Standard_B1s"
  admin_username        = "devlab"
  admin_password        = "Password123"
  network_interface_ids = [azurerm_network_interface.nic1.id, ]

  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

}

# korea vm
resource "azurerm_linux_virtual_machine" "korea" {
  name                  = "asiasevm"
  resource_group_name   = azurerm_resource_group.main.name
  location              = var.korea
  size                  = "Standard_B1s"
  admin_username        = "devlab"
  admin_password        = "Password123"
  network_interface_ids = [azurerm_network_interface.nic2.id, ]


  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }



}

# europe vm
resource "azurerm_linux_virtual_machine" "europe" {
  name                  = "europevm"
  resource_group_name   = azurerm_resource_group.main.name
  location              = var.europe
  size                  = "Standard_B1s"
  admin_username        = "devlab"
  admin_password        = "Password123"
  network_interface_ids = [azurerm_network_interface.nic3.id, ]


  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }



}

# east us vm
resource "azurerm_linux_virtual_machine" "east" {
  name                  = "eastusvm"
  resource_group_name   = azurerm_resource_group.main.name
  location              = var.eastus2
  size                  = "Standard_B1s"
  admin_username        = "devlab"
  admin_password        = "Password123"
  network_interface_ids = [azurerm_network_interface.nic4.id, ]


  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }



}