# Deployment Guide

Complete step-by-step guide to deploy the Azure infrastructure using Terraform.

## Prerequisites

Before starting, ensure you have:

- ✅ **Terraform** installed (v1.0+)
  ```bash
  terraform version
  ```

- ✅ **Azure CLI** installed and configured
  ```bash
  az --version
  az login
  az account set --subscription "ad260aed-6495-48f9-bbbb-54f0f48091e9"
  ```

- ✅ **Git** installed (for cloning)
  ```bash
  git --version
  ```

- ✅ **Appropriate Azure permissions** in the subscription

## 🔑 Authentication Setup

### Option 1: Using Azure CLI (Recommended)

```bash
az login
```

This will open a browser for interactive login.

### Option 2: Service Principal

```bash
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<subscription-id>"
```

Set environment variables:
```bash
export ARM_CLIENT_ID="<client-id>"
export ARM_CLIENT_SECRET="<client-secret>"
export ARM_SUBSCRIPTION_ID="<subscription-id>"
export ARM_TENANT_ID="<tenant-id>"
```

## 📦 Deployment Steps

### Step 1: Clone Repository

```bash
git clone https://github.com/yourusername/azure-terraform-infra.git
cd azure-terraform-infra
```

### Step 2: Deploy Resource Groups

```bash
cd azurerm_resource_group
terraform init
terraform plan
terraform apply -auto-approve
cd ..
```

**Expected Output:**
- ✓ Resource group "rg-king" created in East US
- ✓ Resource group "rg-queen" created in Central US

### Step 3: Deploy Virtual Networks

```bash
cd azurerm_virtual_network
terraform init
terraform plan
terraform apply -auto-approve
cd ..
```

**Expected Output:**
- ✓ Virtual network "vnet" (10.40.0.0/16) created
- ✓ Virtual network "vent1" (10.30.0.0/16) created

### Step 4: Deploy Subnets

```bash
cd azurerm_subnet
terraform init
terraform plan
terraform apply -auto-approve
cd ..
```

**Expected Output:**
- ✓ Subnet "sub-king" (10.40.0.0/25) created in vnet
- ✓ Subnet "sub-king" (10.40.1.0/26) created in vnet
- ✓ Subnet "sub-king" (10.30.1.0/30) created in vent1

### Step 5: Deploy Public IPs

```bash
cd public_ip
terraform init
terraform plan
terraform apply -auto-approve
cd ..
```

**Expected Output:**
- ✓ Public IP "pip-web" allocated (Static, Standard SKU)
- ✓ Public IP "pip-app" allocated (Static, Standard SKU)

### Step 6: Deploy Network Interfaces

```bash
cd NIC
terraform init
terraform plan
terraform apply -auto-approve
cd ..
```

**Expected Output:**
- ✓ NIC "nic-web" created with public IP
- ✓ NIC "nic-app" created with public IP

### Step 7: Deploy Network Security Group

```bash
cd NSG
terraform init
terraform plan
terraform apply -auto-approve
cd ..
```

**Expected Output:**
- ✓ NSG "nsg" created in rg-king
- ✓ Security rule "Allow-SSH" (Port 22, Priority 100)
- ✓ Security rule "Allow-HTTP" (Port 80, Priority 110)

### Step 8: Deploy Storage Accounts

```bash
cd azurerm_storage_account
terraform init
terraform plan
terraform apply -auto-approve
cd ..
```

**Expected Output:**
- ✓ Storage account "storage1" (LRS) created in rg-king
- ✓ Storage account "storage2" (LRS) created in rg-queen

### Step 9: Deploy VNet Peering

```bash
cd azurerm_vnet_peering
terraform init
terraform plan
terraform apply -auto-approve
cd ..
```

**Expected Output:**
- ✓ VNet peering "vnet-peering" established between vnet and vent1

### Step 10: Deploy Bastion Host

```bash
cd azurerm_bastion
terraform init
terraform plan
terraform apply -auto-approve
cd ..
```

**Expected Output:**
- ✓ Bastion host "bastion-host" deployed in rg-king

## ✅ Verification

### Verify Resources in Azure Portal

1. Navigate to [Azure Portal](https://portal.azure.com)
2. Check each resource group:
   - **rg-king**: Contains vnet, NICs, NSG, storage, bastion
   - **rg-queen**: Contains vent1 and storage2

### Verify with Azure CLI

```bash
# List all resource groups
az group list --output table

# List all resources in rg-king
az resource list --resource-group rg-king

# List all resources in rg-queen
az resource list --resource-group rg-queen

# Check VNet peering
az network vnet peering list --resource-group rg-king --vnet-name vnet
```

### Verify with Terraform

```bash
cd azurerm_resource_group
terraform state list
terraform state show
```

## 🔄 Destroy (Cleanup)

To remove all resources in reverse order:

```bash
# Destroy in reverse order of creation
cd azurerm_bastion && terraform destroy -auto-approve && cd ..
cd azurerm_vnet_peering && terraform destroy -auto-approve && cd ..
cd azurerm_storage_account && terraform destroy -auto-approve && cd ..
cd NSG && terraform destroy -auto-approve && cd ..
cd NIC && terraform destroy -auto-approve && cd ..
cd public_ip && terraform destroy -auto-approve && cd ..
cd azurerm_subnet && terraform destroy -auto-approve && cd ..
cd azurerm_virtual_network && terraform destroy -auto-approve && cd ..
cd azurerm_resource_group && terraform destroy -auto-approve && cd ..
```

## 🐛 Troubleshooting

### Issue: Authentication Failed
**Solution:**
```bash
az login
az account set --subscription "ad260aed-6495-48f9-bbbb-54f0f48091e9"
```

### Issue: Resource Already Exists
**Solution:**
```bash
terraform import <resource_type>.<name> <resource_id>
```

### Issue: Insufficient Permissions
**Solution:**
- Ensure your Azure user has "Contributor" role
- Check IAM settings in subscription

### Issue: Terraform Lock File
**Solution:**
```bash
rm .terraform.lock.hcl
terraform init
```

## 📊 Deployment Timeline

| Step | Module | Estimated Time |
|------|--------|-----------------|
| 1 | Resource Groups | 1-2 min |
| 2 | Virtual Networks | 2-3 min |
| 3 | Subnets | 1-2 min |
| 4 | Public IPs | 1 min |
| 5 | NICs | 1-2 min |
| 6 | NSG | 1 min |
| 7 | Storage Accounts | 2-3 min |
| 8 | VNet Peering | 2-3 min |
| 9 | Bastion | 3-5 min |
| **Total** | **All** | **~15-25 min** |

## 📝 Notes

- All resources are created in East US or Central US regions
- Storage accounts use LRS replication for cost-effectiveness
- Security group allows SSH (22) and HTTP (80) by default
- Bastion host provides secure remote access
- NICs have dynamic private IP allocation

## 🔐 Security Recommendations

1. ✅ Restrict NSG rules to specific IP ranges in production
2. ✅ Enable Azure Firewall for additional protection
3. ✅ Use Private Link for storage accounts
4. ✅ Enable diagnostic logging for all resources
5. ✅ Implement Azure Policy for governance
6. ✅ Use managed identities for service authentication

---

**Last Updated**: June 12, 2026
