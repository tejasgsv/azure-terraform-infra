# Azure Infrastructure as Code (Terraform)

A comprehensive Terraform project for deploying production-grade Azure infrastructure including networking, security, storage, and bastion host configurations.

## 📋 Project Overview

This repository contains modular Terraform configurations for deploying a complete Azure infrastructure with:

- **Resource Groups** - Logically organize Azure resources across regions
- **Virtual Networks** - Create isolated network environments (vnet/vent1)
- **Subnets** - Segment virtual networks with multiple address spaces
- **Public IPs** - Static IP addresses for internet-facing resources
- **Network Interfaces (NIC)** - Connect VMs to subnets with dynamic IP allocation
- **Network Security Groups (NSG)** - Control inbound/outbound traffic with security rules
- **Storage Accounts** - Cloud storage with redundancy options
- **VNet Peering** - Connect multiple virtual networks securely
- **Bastion Host** - Secure remote access without exposing SSH/RDP ports

## 🏗️ Project Structure

```
Assignment/
├── azurerm_resource_group/      # Resource groups for rg-king and rg-queen
├── azurerm_virtual_network/     # Virtual networks (vnet, vent1)
├── azurerm_subnet/              # Subnets across multiple vnets
├── azurerm_storage_account/     # Storage accounts with LRS replication
├── public_ip/                   # Public IP addresses (pip-web, pip-app)
├── NIC/                         # Network interface cards
├── NSG/                         # Network security groups with rules
├── azurerm_vnet_peering/        # VNet peering connections
├── azurerm_bastion/             # Bastion host for secure access
├── README.md                    # Project documentation
├── DEPLOYMENT_GUIDE.md          # Step-by-step deployment instructions
├── ARCHITECTURE.md              # Infrastructure architecture details
├── requirements.md              # Tools and prerequisites
└── .gitignore                   # Git ignore patterns
```

## 🚀 Quick Start

### Prerequisites
- Terraform >= 1.0
- Azure CLI configured with valid credentials
- Active Azure subscription
- Git for version control

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/azure-terraform-infra.git
   cd azure-terraform-infra
   ```

2. **Initialize Terraform**
   ```bash
   cd <module-directory>
   terraform init
   ```

3. **Review the plan**
   ```bash
   terraform plan
   ```

4. **Apply the configuration**
   ```bash
   terraform apply
   ```

## 📦 Modules Description

| Module | Purpose | Resources |
|--------|---------|-----------|
| `azurerm_resource_group` | Create resource groups | 2 RGs (rg-king, rg-queen) |
| `azurerm_virtual_network` | Create vnets | 2 Virtual Networks |
| `azurerm_subnet` | Create subnets | 3 Subnets across vnets |
| `public_ip` | Allocate public IPs | 2 Static Public IPs |
| `NIC` | Create network interfaces | 2 NICs for VMs |
| `NSG` | Create security groups | 1 NSG with SSH/HTTP rules |
| `azurerm_storage_account` | Create storage | 2 Storage Accounts (LRS) |
| `azurerm_vnet_peering` | Peer networks | vnet ↔ vent1 peering |
| `azurerm_bastion` | Deploy bastion | 1 Bastion host instance |

## 🔧 Configuration

### Resource Groups
- **rg-king** (East US)
- **rg-queen** (Central US)

### Virtual Networks
- **vnet** (10.40.0.0/16) - East US
- **vent1** (10.30.0.0/16) - Central US

### Subnets
- **sub-king** (10.40.0.0/25, 10.40.1.0/26) - vnet
- **sub-king** (10.30.1.0/30) - vent1

### Security Rules (NSG)
- **Allow-SSH**: Port 22 (Priority 100)
- **Allow-HTTP**: Port 80 (Priority 110)

## 📝 Variables

Each module has its own variables. See `terraform.tfvars` in each module directory for current values:

```hcl
# Example: azurerm_resource_group/terraform.tfvars
var_tej = {
  tej1 = {
    name     = "rg-king"
    location = "eastus"
  }
  tej2 = {
    name     = "rg-queen"
    location = "centralus"
  }
}
```

## 🔐 Security

- ✅ All subnets configured with proper CIDR blocks
- ✅ NSG rules restrict access to SSH (22) and HTTP (80)
- ✅ Public IPs with Standard SKU for enhanced security
- ✅ Bastion host provides secure RDP/SSH access
- ✅ Storage accounts with LRS replication for redundancy

## 📊 Deployment Order

Follow this order for successful deployment:

1. `azurerm_resource_group` - Create resource groups
2. `azurerm_virtual_network` - Create virtual networks
3. `azurerm_subnet` - Create subnets
4. `public_ip` - Allocate public IPs
5. `NIC` - Create network interfaces
6. `NSG` - Setup security groups
7. `azurerm_storage_account` - Create storage
8. `azurerm_vnet_peering` - Peer the networks
9. `azurerm_bastion` - Deploy bastion host

## 🧹 Cleanup

To destroy all resources:

```bash
cd <module-directory>
terraform destroy
```

## 📚 Documentation

- [DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md) - Detailed deployment instructions
- [ARCHITECTURE.md](ARCHITECTURE.md) - Infrastructure architecture diagrams and details
- [requirements.md](requirements.md) - Tools, versions, and prerequisites

## 🔄 Azure Subscription

- **Subscription ID**: `ad260aed-6495-48f9-bbbb-54f0f48091e9`
- **Provider**: Azure Resource Manager (azurerm)
- **Terraform Version**: 4.1.0

## 📧 Support & Contribution

For issues, questions, or contributions:
- Create an issue on GitHub
- Submit a pull request with improvements
- Contact the team for enterprise support

## 📄 License

This project is licensed under the MIT License - see LICENSE file for details.

## 🎯 Best Practices Implemented

✅ Modular Terraform structure
✅ Consistent variable naming conventions
✅ Comprehensive .gitignore
✅ Proper resource organization
✅ Security group controls
✅ Regional redundancy
✅ Infrastructure as Code principles

---

**Last Updated**: June 12, 2026  
**Status**: Production Ready
