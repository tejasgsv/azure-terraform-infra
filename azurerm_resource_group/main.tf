resource "azurerm_resource_group" "tejas_rg" {

    for_each = var.var_tej

    name = each.value.name
    location = each.value.location
  
}