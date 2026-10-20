terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "identity" {
  name     = var.resource_group_name
  location = var.location

  tags = var.tags
}

resource "azurerm_virtual_network" "identity" {
  name                = var.virtual_network_name
  location            = azurerm_resource_group.identity.location
  resource_group_name = azurerm_resource_group.identity.name
  address_space       = [var.vnet_address_space]

  tags = var.tags
}

resource "azurerm_subnet" "identity" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.identity.name
  virtual_network_name = azurerm_virtual_network.identity.name
  address_prefixes     = [var.subnet_address_prefix]
}

resource "azurerm_network_security_group" "identity" {
  name                = var.network_security_group_name
  location            = azurerm_resource_group.identity.location
  resource_group_name = azurerm_resource_group.identity.name

  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "identity" {
  subnet_id                 = azurerm_subnet.identity.id
  network_security_group_id = azurerm_network_security_group.identity.id
}

locals {
  virtual_machines = {
    directory = {
      name         = var.directory_vm_name
      private_host = 4
    }
    sync = {
      name         = var.sync_vm_name
      private_host = 5
    }
  }
}

resource "azurerm_network_interface" "vm" {
  for_each = local.virtual_machines

  name                = "${each.value.name}-nic"
  location            = azurerm_resource_group.identity.location
  resource_group_name = azurerm_resource_group.identity.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.identity.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.subnet_address_prefix, each.value.private_host)
  }

  tags = var.tags
}

resource "azurerm_windows_virtual_machine" "vm" {
  for_each = local.virtual_machines

  name                = each.value.name
  computer_name       = each.value.name
  location            = azurerm_resource_group.identity.location
  resource_group_name = azurerm_resource_group.identity.name
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password

  network_interface_ids = [
    azurerm_network_interface.vm[each.key].id
  ]

  # Image is configurable because the exact marketplace image version used
  # in the deleted deployment cannot be recovered with certainty.
  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  os_disk {
    name                 = "${each.value.name}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  # Do not attach public IP addresses to these VMs.
  boot_diagnostics {}

  tags = var.tags
}
