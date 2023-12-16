resource "azurerm_resource_group" "grp" {
  name     = "grp"
  location = "eastus"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks"
  location            = azurerm_resource_group.grp.location
  resource_group_name = azurerm_resource_group.grp.name
  dns_prefix          = "dnsAks"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw

  sensitive = true
}