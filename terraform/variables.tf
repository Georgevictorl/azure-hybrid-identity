variable "resource_group_name" {
  description = "Name for the dedicated resource group."
  type        = string
  default     = "rg-hybrid-identity"
}

variable "location" {
  description = "Azure region for all resources."
  type        = string
}

variable "virtual_network_name" {
  description = "Virtual network name."
  type        = string
  default     = "vnet-hybrid-identity"
}

variable "vnet_address_space" {
  description = "Private IPv4 CIDR for the virtual network; choose a range that does not overlap connected networks."
  type        = string
}

variable "subnet_name" {
  description = "Identity subnet name."
  type        = string
  default     = "snet-identity"
}

variable "subnet_address_prefix" {
  description = "Subnet CIDR contained within vnet_address_space."
  type        = string
}

variable "network_security_group_name" {
  description = "Network Security Group name."
  type        = string
  default     = "nsg-hybrid-identity"
}

variable "directory_vm_name" {
  description = "Windows Server VM for AD DS and DNS."
  type        = string
  default     = "vm-directory-01"
}

variable "sync_vm_name" {
  description = "Windows Server VM for Microsoft Entra Connect Sync."
  type        = string
  default     = "vm-entra-sync-01"
}

variable "vm_size" {
  description = "Azure VM size. Select a size available in the chosen region."
  type        = string
  default     = "Standard_B2s"
}

variable "admin_username" {
  description = "Local Windows administrator username."
  type        = string
  sensitive   = true
}

variable "admin_password" {
  description = "Local Windows administrator password. Supply through TF_VAR_admin_password or a secret manager."
  type        = string
  sensitive   = true
}

variable "image_publisher" {
  description = "Azure Marketplace image publisher."
  type        = string
  default     = "MicrosoftWindowsServer"
}

variable "image_offer" {
  description = "Azure Marketplace image offer."
  type        = string
  default     = "WindowsServer"
}

variable "image_sku" {
  description = "Azure Marketplace image SKU; verify availability in the chosen region."
  type        = string
  default     = "2022-datacenter-azure-edition"
}

variable "image_version" {
  description = "Azure Marketplace image version. 'latest' follows the current publisher image."
  type        = string
  default     = "latest"
}

variable "tags" {
  description = "Tags applied to supported resources."
  type        = map(string)
  default = {
    workload = "identity"
    project  = "hybrid-identity"
  }
}
