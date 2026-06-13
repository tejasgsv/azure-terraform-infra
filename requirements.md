# Requirements & Prerequisites

## 🖥️ System Requirements

### Minimum Hardware
- **RAM**: 4GB (8GB recommended)
- **Storage**: 2GB free disk space
- **CPU**: 2-core processor
- **OS**: Windows, macOS, or Linux

### Supported Operating Systems
- Windows 10/11 Pro or higher
- macOS 10.15+
- Ubuntu 18.04+
- RHEL 7+
- Other Linux distributions

## 📦 Software Requirements

### Required Tools

#### 1. Terraform
- **Version**: 1.0 or higher (tested with 1.5+)
- **Download**: [terraform.io/downloads](https://www.terraform.io/downloads)
- **Installation**:
  ```bash
  # Windows (using Chocolatey)
  choco install terraform
  
  # macOS (using Homebrew)
  brew install terraform
  
  # Linux
  wget https://releases.hashicorp.com/terraform/1.5.0/terraform_1.5.0_linux_amd64.zip
  unzip terraform_1.5.0_linux_amd64.zip
  sudo mv terraform /usr/local/bin/
  ```
- **Verification**:
  ```bash
  terraform version
  ```

#### 2. Azure CLI
- **Version**: 2.40.0 or higher
- **Download**: [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli)
- **Installation**:
  ```bash
  # Windows (using Chocolatey)
  choco install azure-cli
  
  # macOS (using Homebrew)
  brew install azure-cli
  
  # Linux
  curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
  ```
- **Verification**:
  ```bash
  az --version
  ```

#### 3. Git
- **Version**: 2.30 or higher
- **Download**: [git-scm.com](https://git-scm.com)
- **Installation**:
  ```bash
  # Windows (using Chocolatey)
  choco install git
  
  # macOS (using Homebrew)
  brew install git
  
  # Linux
  sudo apt-get install git
  ```
- **Verification**:
  ```bash
  git --version
  ```

### Optional Tools

#### Visual Studio Code
- **Download**: [code.visualstudio.com](https://code.visualstudio.com)
- **Recommended Extensions**:
  - HashiCorp Terraform
  - Azure Terraform
  - Azure CLI Tools
  - Git Graph

#### PowerShell
- **Version**: 7.0+ (Core)
- **Download**: [PowerShell GitHub](https://github.com/PowerShell/PowerShell)

#### Postman
- For testing Azure REST APIs
- **Download**: [postman.com](https://www.postman.com)

## ☁️ Azure Requirements

### Azure Subscription
- ✅ Active Azure Subscription
- ✅ Subscription ID: `<your-subscription-id>`
- ✅ Valid payment method on file

### Azure Permissions
Required RBAC Role: **Contributor**

**Minimum Permissions Needed**:
- `Microsoft.Resources/resourceGroups/write`
- `Microsoft.Network/virtualNetworks/write`
- `Microsoft.Network/subnets/write`
- `Microsoft.Network/networkInterfaces/write`
- `Microsoft.Network/publicIPAddresses/write`
- `Microsoft.Network/networkSecurityGroups/write`
- `Microsoft.Compute/virtualMachines/write`
- `Microsoft.Storage/storageAccounts/write`
- `Microsoft.Network/bastionHosts/write`
- `Microsoft.Network/virtualNetworks/virtualNetworkPeerings/write`

## 🔑 Authentication Setup

### Step 1: Azure CLI Login
```bash
# Interactive login
az login

# Verify subscription
az account show

# Set subscription (if needed)
az account set --subscription "<your-subscription-id>"
```

### Step 2: Verify Authentication
```bash
az account list --output table
```

### Alternative: Service Principal Authentication
```bash
# Create service principal
az ad sp create-for-rbac --role="Contributor" \
  --scopes="/subscriptions/ad260aed-6495-48f9-bbbb-54f0f48091e9" \
  --output json

# Set environment variables
export ARM_CLIENT_ID="<appId>"
export ARM_CLIENT_SECRET="<password>"
export ARM_SUBSCRIPTION_ID="ad260aed-6495-48f9-bbbb-54f0f48091e9"
export ARM_TENANT_ID="<tenant>"
```

## 📝 Installation Checklist

- [ ] Terraform 1.0+ installed
- [ ] Azure CLI 2.40.0+ installed
- [ ] Git 2.30+ installed
- [ ] Azure account authenticated
- [ ] Correct subscription selected
- [ ] Contributor role assigned
- [ ] VS Code with Terraform extension (optional)
- [ ] GitHub account created
- [ ] GitHub SSH keys configured (optional)

## ✅ Verification Script

```bash
#!/bin/bash
# Verify all requirements

echo "Checking Terraform..."
terraform version

echo "Checking Azure CLI..."
az --version

echo "Checking Git..."
git --version

echo "Checking Azure Authentication..."
az account show

echo "Checking Terraform Azure Provider..."
terraform -version

echo "✅ All checks complete!"
```

**Run on Linux/macOS**:
```bash
bash verify-requirements.sh
```

**Run on Windows PowerShell**:
```powershell
$checks = @{
  "Terraform" = "terraform version"
  "Azure CLI" = "az --version"
  "Git" = "git --version"
  "Azure Auth" = "az account show"
}

foreach ($check in $checks.GetEnumerator()) {
  Write-Host "Checking $($check.Name)..."
  Invoke-Expression $check.Value
}
```

## 📚 Documentation References

### Official Documentation
- [Terraform Documentation](https://www.terraform.io/docs)
- [Azure Provider for Terraform](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Azure CLI Documentation](https://docs.microsoft.com/cli/azure/)
- [Microsoft Azure Documentation](https://docs.microsoft.com/azure/)

### Learning Resources
- [Terraform Learning Path](https://learn.hashicorp.com/terraform)
- [Azure Fundamentals](https://docs.microsoft.com/learn/paths/azure-fundamentals/)
- [Infrastructure as Code](https://learn.hashicorp.com/collections/terraform/aws-get-started)

## 💰 Cost Estimation

### Estimated Monthly Costs (rough estimate)

| Resource | Type | Estimated Cost |
|----------|------|-----------------|
| Virtual Networks | Networking | Free |
| Subnets | Networking | Free |
| Public IPs (x2) | Networking | ~$2.92/month each |
| Network Interfaces (x2) | Networking | Free (attached to VMs) |
| NSG | Security | Free |
| Bastion Host | Gateway | ~$135/month |
| Storage Accounts (x2) | Storage | ~$1/month each |
| **Total (Estimated)** | - | **~$145-200/month** |

*Note: Costs vary by region and usage. For accurate pricing, use [Azure Pricing Calculator](https://azure.microsoft.com/pricing/calculator/)*

## ⚙️ Environment Variables

### Terraform
```bash
# Optional: Set log level
export TF_LOG=DEBUG

# Optional: Set log path
export TF_LOG_PATH=./terraform.log

# Optional: Skip plugin cache
export TF_PLUGIN_CACHE_DIR=~/.terraform.d/plugin-cache
```

### Azure Provider
```bash
# Azure credentials
export ARM_CLIENT_ID="<client-id>"
export ARM_CLIENT_SECRET="<client-secret>"
export ARM_SUBSCRIPTION_ID="<subscription-id>"
export ARM_TENANT_ID="<tenant-id>"
```

## 🆘 Troubleshooting

### Issue: Terraform not found
```bash
# Add to PATH (Windows)
setx PATH "%PATH%;C:\Program Files\Terraform"

# Add to PATH (Linux/macOS)
export PATH="/usr/local/bin:$PATH"
```

### Issue: Azure CLI authentication failed
```bash
az login --use-device-code
# or
az login --username <email>
```

### Issue: Insufficient permissions
Contact your Azure subscription owner for Contributor role assignment.

### Issue: Terraform initialization fails
```bash
# Clear cache and reinitialize
rm -rf .terraform
rm .terraform.lock.hcl
terraform init
```

## 📞 Support

For issues and support:
- Check official documentation
- Review troubleshooting section
- Submit GitHub issues
- Contact Azure support

---

**Last Updated**: June 12, 2026  
**Status**: All Requirements Current
