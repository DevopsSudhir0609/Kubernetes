

resource "azurerm_kubernetes_cluster" "main" {
  name                = var.component
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  dns_prefix          = "dev"

 default_node_pool {
    name       = "nodepool1"
    node_count = 1
    vm_size    = "Standard_D2_v2"
    auto_scaling_enabled = true
    min_count = 1
    max_count = 3
    vnet_subnet_id = data.azurerm_subnet.main.id

  }
  network_profile {
  network_plugin = "azure"
  service_cidr   = "10.100.0.0/24"
  dns_service_ip = "10.100.0.100"
}
  aci_connector_linux {
    subnet_name = data.azurerm_subnet.main.id
  }
  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}
resource "azurerm_role_assignment" "dns_zone_contributor" {
  scope                = "/subscriptions/${var.subscription_id}/resourceGroups/project-alpha/providers/Microsoft.Network/dnsZones/espnitsolutions.com"
  role_definition_name = "DNS Zone Contributor"
  principal_id         = azurerm_kubernetes_cluster.main.identity[0].principal_id
}

output "azurerm_kubernetes_cluster" {
  value = azurerm_kubernetes_cluster.main.id
  
}
