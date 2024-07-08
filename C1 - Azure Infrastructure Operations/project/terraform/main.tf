provider "azurerm"{
  features {}
}
resource "azurerm_linux_virtual_machine" "example" {
  name = "${var.prefix}-vm"
  resource_group_name = "${var.resource_group}"
  location = var.location


  source_image_reference {
    publisher = "Canonical"
    offer = "UbuntuServer"
    sku = "20.04-LTS"
    version = "latest"
  }
}
