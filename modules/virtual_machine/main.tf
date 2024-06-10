resource "azurerm_network_interface" "vm" {
  name                = join("-", concat(["nic"], [var.vm_name]))
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "dynamic"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  count               = var.os_type == "windows" ? 1 : 0
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location

  computer_name         = var.vm_hostname
  admin_password        = var.vm_password
  admin_username        = var.vm_username
  network_interface_ids = [azurerm_network_interface.vm.id]
  size                  = var.vm_sku
  os_disk {
    caching              = "ReadOnly"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  count               = var.os_type == "linux" ? 1 : 0
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location

  computer_name         = var.vm_hostname
  admin_password        = var.vm_password
  admin_username        = var.vm_username
  network_interface_ids = [azurerm_network_interface.vm.id]
  size                  = var.vm_sku

  disable_password_authentication = false
  os_disk {
    caching              = "ReadOnly"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
