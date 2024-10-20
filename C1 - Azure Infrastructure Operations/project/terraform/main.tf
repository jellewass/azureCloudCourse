
provider "azurerm" {
  features {}
}

resource "azurerm_virtual_network" "example" {
  name                = "${var.prefix}-vnet"
  resource_group_name = "${var.resource_group}"
  location            = var.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = "${var.resource_group}"
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "example" {
  name                = "${var.prefix}-nic"
  resource_group_name = "${var.resource_group}"
  location            = var.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "example" {
  count               = var.instance_count
  name                = "${var.prefix}-vm"
  resource_group_name = "${var.resource_group}"
  admin_username      = "adminuser"
  location            = var.location
  size                = "Standard_F2"
  tags = {
    Project = var.project_name
  }
  disable_password_authentication = true
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "22.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}

resource "azurerm_lb_backend_address_pool" "example" {
  name                = "${var.prefix}-backend-pool"
  resource_group_name = "${var.resource_group}"
  loadbalancer_id     = azurerm_lb.example.id
}

resource "azurerm_network_interface_backend_address_pool_association" "example" {
  network_interface_id    = azurerm_network_interface.example.id
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.example.id
}

resource "azurerm_managed_disk" "example" {
  name                 = "${var.prefix}-managed-disk"
  resource_group_name  = "${var.resource_group}"
  location             = var.location
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 1024
}

resource "azurerm_virtual_machine_data_disk_attachment" "example" {
  managed_disk_id    = azurerm_managed_disk.example.id
  virtual_machine_id = azurerm_linux_virtual_machine.example.id
  lun                = 0
}

resource "azurerm_network_security_group" "example" {
  name                = "${var.prefix}-nsg"
  resource_group_name = "${var.resource_group}"
  location            = var.location
}

resource "azurerm_network_security_rule" "example" {
  name                        = "${var.prefix}-nsg-rule"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.example.name
}

resource "azurerm_public_ip" "example" {
  name                = "${var.prefix}-public-ip"
  resource_group_name = "${var.resource_group}"
  location            = var.location
  allocation_method   = "Dynamic"
}

resource "azurerm_lb" "example" {
  name                = "${var.prefix}-lb"
  resource_group_name = "${var.resource_group}"
  location            = var.location
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.example.id
  }
}

resource "azurerm_lb_rule" "example" {
  name                           = "${var.prefix}-lb-rule"
  resource_group_name            = "${var.resource_group}"
  loadbalancer_id                = azurerm_lb.example.id
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_id        = azurerm_lb_backend_address_pool.example.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
}






