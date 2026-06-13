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

## 📦 Module Breakdown

| Module | Purpose | Resources |
|--------|---------|-----------|
| `azurerm_resource_group` | Base logical containers | East US & Central US |
| `azurerm_virtual_network` | Network foundation | Isolated VNets |
| `azurerm_subnet` | Network segmentation | Subnets with custom CIDR |
| `NSG` | Traffic control | Security rules (SSH/HTTP) |
| `azurerm_vnet_peering` | Cross-region connectivity | Private peering connection |
| `azurerm_bastion` | Secure access gateway | Managed Bastion Host |

## 🧹 Cleanup

To avoid unnecessary Azure charges, destroy all resources when done:

```bash
cd <module-directory>
terraform destroy -auto-approve
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
