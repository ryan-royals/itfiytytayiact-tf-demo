locals {
  naming = {
    prefix = [lower(var.naming.org_code)]
    suffix = [lower(var.naming.application_code), lower(var.naming.environment_code), lower(var.naming.location_code)]
  }
  # https://registry.terraform.io/modules/hashicorp/subnets/cidr/latest
  subnet_new_bits = [
    for i, n in var.networking.subnets : {
      name     = n.name
      new_bits = n.address_prefix - regex("\\d{1,2}$", var.networking.address_space)
    }
  ]
  subnet_cidr_blocks = cidrsubnets(var.networking.address_space, local.subnet_new_bits[*].new_bits...)
  subnets = [
    for i, o in local.subnet_new_bits : {
      name           = o.name
      new_bits       = o.new_bits
      address_prefix = local.subnet_cidr_blocks[i]
    }
  ]
}

module "naming" {
  source  = "Azure/naming/azurerm"
  prefix = local.naming.prefix
  suffix = local.naming.suffix
}
