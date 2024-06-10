variable "resource_group_name" {
  description = "The name of the resource group in which to create the virtual machine"
  type        = string
}

variable "location" {
  description = "The Azure region in which to create the virtual machine"
  type        = string
}

variable "vm_name" {
  description = "The name the virtual machine. Used to identify the object in Azure"
  type        = string
}

variable "vm_hostname" {
  description = "The hostname of the virtual machine. Must be less than 15 characters"
  type        = string
  validation {
    condition     = length(var.vm_hostname) <= 15
    error_message = "The virtual machine name must be less than 15 characters"
  }
}

variable "vm_username" {
  description = "The username for the virtual machine"
  type        = string
  default     = "ladmin"
  nullable    = false
}

variable "vm_password" {
  description = "The password for the virtual machine"
  type        = string
}

variable "vm_sku" {
  description = "The SKU of the virtual machine. Must be Standard_B1s, Standard_B2s or Standard_B4ms"
  type        = string
  default     = "Standard_B1s"
  validation {
    condition     = contains(["Standard_B1s", "Standard_B2s", "Standard_B4ms"], var.vm_sku)
    error_message = "The virtual machine SKU must be either Standard_B1s, Standard_B2s or Standard_B4ms"
  }
}

variable "os_type" {
  description = "The type of operating system to use. Must be either linux or windows"
  type        = string
  default     = "linux"
  validation {
    condition     = contains(["linux", "windows"], var.os_type)
    error_message = "The operating system must be either linux or windows"
  }
}

variable "subnet_id" {
  description = "The ID of the subnet to deploy the virtual machine into"
  type        = string
}
