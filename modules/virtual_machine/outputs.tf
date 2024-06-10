output "nic" {
  value       = azurerm_network_interface.vm
  description = "The network interface object for the virtual machine"
}

output "vm" {
  value       = var.os_type == "linux" ? azurerm_linux_virtual_machine.vm[0] : azurerm_windows_virtual_machine.vm[0]
  description = "The virtual machine object for the virtual machine"
}
