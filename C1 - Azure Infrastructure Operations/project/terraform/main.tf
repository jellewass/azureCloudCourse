provider "azurerm"{
  features {}
}
resource "azurerm_linux_virtual_machine" "example" {
  name = "${var.prefix}-vm"
  resource_group_name = azurerm_resource_group.example.name
  location = var.location


  source_image_reference {
    publisher = "Canonical"
    offer = "UbuntuServer"
    sku = "20.04-LTS"
    version = "latest"
  }
}
