variable "subscription_id" {
  type        = string
  description = "Azure subscription ID to deploy resources to. Example: '00000000-0000-0000-0000-000000000000'"
  sensitive   = true
}

variable "location" {
  type        = string
  description = "Azure location to deploy resources to. Example: 'australiaEast'"
  default     = "australiaEast"
}

variable "naming" {
  type = object({
    org_code         = string
    application_code = string
    environment_code = string
    location_code    = string
  })
  description = <<EOT
    Naming convention for resources
    
    - org_code: 3 letter code for the organisation. Example. 'rrr'
    - application_code: 3 letter code for the application. Example: 'adl'
    - environment_code: 3 letter code for the environment classification. Example: 'dev'
    - location_code: 3 letter code for the datacenter location. Example: 'aue'
    EOT
}

variable "networking" {
  type = object({
    address_space = string
    subnets = list(object({
      name           = string
      address_prefix = number
    }))
  })
  description = <<EOT
    Networking configuration for the virtual network
    
    - address_space: CIDR Block for the virtual network. Example: "192.168.1.1/24"
    - subnets: List of subnets to create in the virtual network. 
        - name: Name of the subnet. Example: "vm"
        - address_prefix: CIDR Notation for the subnet. Example: "27"
    EOT
}

variable "virtual_machines" {
  type = list(object({
    vm_name_suffix = string
    vm_hostname    = string
    vm_username    = optional(string)
    vm_password    = string
    vm_sku         = string
    os_type        = string
    subnet_name    = string
  }))
  description = <<EOT
    List of virtual machines to create

    - vm_name_suffix: Suffix to append to the virtual machine name. Must be unique. Example: "01" 
    - vm_hostname: The hostname of the virtual machine. Must be less than 15 characters. Example: "vm"
    - vm_password: The password for the virtual machine. Example: "P@ssw0rd1234"
    - vm_sku: The SKU of the virtual machine. Must be Standard_B1s, Standard_B2s or Standard_B4ms. Example: "Standard_B1s"
    - os_type: The type of operating system to use. Must be either linux or windows. Example: "linux"
    - subnet_name: Name of the subnet to deploy the virtual machine into, referencing the name from the networking.subnets variable. Example: "vm"
    EOT
  validation {
    condition     = length([for o in var.virtual_machines : o.vm_name_suffix]) == length(distinct([for o in var.virtual_machines : o.vm_name_suffix]))
    error_message = "vm_name_suffix must be unique"
  }
}