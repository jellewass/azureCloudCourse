provider "azurerm"{
  features {}
}

resource "azurerm_virtual_network" "example" {
  name = "${var.prefix}-vnet"
  resource_group_name = "${var.resource_group}"
  location = var.location
  address_space = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "internal" {
  name = "internal"
  resource_group_name = "${var.resource_group}"
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "example" {
  name = "${var.prefix}-nic"
  resource_group_name = "${var.resource_group}"
  location = var.location

  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "example" {
  name = "var.prefix-vm"
  resource_group_name = "${var.resource_group}"
  admin_username = "adminuser"
  location = var.location
  size = "Standard_F2"
  disable_password_authentication = true
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  source_image_reference {
    publisher = "Canonical"
    offer = "UbuntuServer"
    sku = "22.04-LTS"
    version = "latest" 
  }
  os_disk {
    storage_account_type = "Standard_LRS"
    caching = "ReadWrite"
  }  
}



