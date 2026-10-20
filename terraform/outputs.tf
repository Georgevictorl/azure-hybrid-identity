output "resource_group_name" {
  description = "Name of the created resource group."
  value       = azurerm_resource_group.identity.name
}

output "virtual_network_name" {
  description = "Name of the created virtual network."
  value       = azurerm_virtual_network.identity.name
}

output "virtual_machine_names" {
  description = "Names of the created Windows virtual machines."
  value       = [for vm in azurerm_windows_virtual_machine.vm : vm.name]
}
