location = "australiaEast"
naming = {
  org_code         = "rrr"
  application_code = "adl"
  environment_code = "dev"
  location_code    = "aue"
}
networking = {
  address_space = "192.168.1.0/24"
  subnets = [{
    name           = "vm"
    address_prefix = 27
    },
    {
      name           = "app"
      address_prefix = 27
  }]
}
virtual_machines = [
  {
    vm_hostname    = "windowsvm"
    vm_name_suffix = "01"
    vm_password    = "This1sV3ry$3cure"
    vm_sku         = "Standard_B1s"
    os_type        = "windows"
    subnet_name    = "vm"
  },
  {
    vm_hostname    = "linuxvm"
    vm_name_suffix = "02"
    vm_password    = "No,1D0n'tKnowH0w1G0tH@ck3d!"
    vm_sku         = "Standard_B1s"
    subnet_name    = "vm"
    os_type        = "linux"
  }
]
