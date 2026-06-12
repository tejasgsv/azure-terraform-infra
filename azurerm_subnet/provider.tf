terraform {

    required_providers {
        
        azurerm = {

        source = "hashicorp/azurerm"
        version = "=4.1.0"

    }
}
}

provider "azurerm"{

    subscription_id = "ad260aed-6495-48f9-bbbb-54f0f48091e9"
    features {}
}