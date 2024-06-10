module "vm" {
  for_each = {
    for o in var.virtual_machines : o.vm_name_suffix => o
  }

  source = "./modules/virtual_machine"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  vm_name     = join("-", concat(local.naming.prefix, ["vm"], local.naming.suffix, [each.value.vm_name_suffix]))
  vm_hostname = each.value.vm_hostname
  vm_username = each.value.vm_username
  vm_password = each.value.vm_password
  vm_sku      = each.value.vm_sku
  os_type     = each.value.os_type
  subnet_id   = local.deployed_subnets[each.value.subnet_name].id
}