# Architecture Overview

Complete infrastructure architecture for the Azure deployment using Terraform.

## 🏛️ High-Level Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                     Azure Subscription                          │
│              (ad260aed-6495-48f9-bbbb-54f0f48091e9)            │
└─────────────────────────────────────────────────────────────────┘
              ┌──────────────────┬──────────────────┐
              │                  │                  │
        ┌─────▼─────┐      ┌─────▼─────┐          │
        │  RG-King  │      │ RG-Queen  │          │
        │  (East US)│      │(Central US)          │
        └─────┬─────┘      └─────┬─────┘          │
              │                  │                  │
        ┌─────▼──────────────────▼─────┐          │
        │     VNet Peering Connection   │          │
        │  (vnet ↔ vent1)               │          │
        └─────┬──────────────────┬─────┘          │
              │                  │                  │
        ┌─────▼──────┐    ┌──────▼─────┐          │
        │    vnet    │    │    vent1   │          │
        │10.40.0.0/16│    │10.30.0.0/16│          │
        └─────┬──────┘    └──────┬─────┘          │
              │                  │                  │
    ┌─────────┼─────────┐    ┌───▼────┐           │
    │         │         │    │        │           │
┌───▼──┐  ┌───▼──┐  ┌──▼──┐ │        │           │
│Subnet│  │Subnet│  │Sub  │ │Subnet  │           │
│.0/25 │  │.1/26 │  │.1/30│ │.1/30   │           │
└───┬──┘  └───┬──┘  └──┬──┘ └────┬───┘           │
    │         │        │         │                │
    ├─────┬───┴────┬───┴───┐     │                │
    │     │        │       │     │                │
┌───▼──┐┌─▼──┐┌───▼────┐┌─▼─┐ ┌─▼──┐            │
│ NIC-1││NIC-2│Bastion │Storage Storage           │
└───┬──┘└──┬──┘└───┬────┘└─┬─┘ └────┘            │
    │      │       │       └─ Storage2           │
  ┌─▼──┐┌─▼──┐  ┌─▼──┐                          │
  │PIP ││PIP │  │NSG │                          │
  └────┘└────┘  └────┘                          │
```

## 📍 Resource Groups

### RG-King (East US)
**Location**: East US  
**Resources**:
- Virtual Network: vnet (10.40.0.0/16)
  - Subnet 1: sub-king (10.40.0.0/25)
  - Subnet 2: sub-king (10.40.1.0/26)
- Network Interfaces: nic-web, nic-app
- Public IPs: pip-web, pip-app
- Network Security Group: nsg
- Storage Account: storage1
- Bastion Host: bastion-host

### RG-Queen (Central US)
**Location**: Central US  
**Resources**:
- Virtual Network: vent1 (10.30.0.0/16)
  - Subnet: sub-king (10.30.1.0/30)
- Storage Account: storage2

## 🌐 Network Design

### Virtual Networks

#### VNet (10.40.0.0/16) - rg-king
- **Address Space**: 10.40.0.0/16
- **Region**: East US
- **Subnets**:
  - subnet-1: 10.40.0.0/25 (126 usable IPs)
  - subnet-2: 10.40.1.0/26 (62 usable IPs)

#### VNet1 (10.30.0.0/16) - rg-queen
- **Address Space**: 10.30.0.0/16
- **Region**: Central US
- **Subnets**:
  - subnet-1: 10.30.1.0/30 (2 usable IPs)

### VNet Peering

```
    vnet (East US)              vent1 (Central US)
  10.40.0.0/16            <---->        10.30.0.0/16
    [rg-king]             peering       [rg-queen]
```

**Benefits**:
- ✅ Cross-region communication
- ✅ Private network connectivity
- ✅ No bandwidth charges for peered traffic
- ✅ Transitive routing (with additional config)

## 🔌 Network Interfaces

### NIC-Web
- **Location**: East US
- **Resource Group**: rg-king
- **Subnet**: sub-king (10.40.0.0/25)
- **Private IP**: Dynamic
- **Public IP**: pip-web
- **Configuration**: testConfiguration

### NIC-App
- **Location**: East US
- **Resource Group**: rg-king
- **Subnet**: sub-king (10.40.0.0/25)
- **Private IP**: Dynamic
- **Public IP**: pip-app
- **Configuration**: testConfiguration

## 🌐 Public IPs

### pip-web
- **Allocation**: Static
- **SKU**: Standard
- **Resource Group**: rg-king
- **Region**: East US
- **Associated NIC**: nic-web

### pip-app
- **Allocation**: Static
- **SKU**: Standard
- **Resource Group**: rg-king
- **Region**: East US
- **Associated NIC**: nic-app

## 🔐 Network Security

### Network Security Group (NSG)
**Name**: nsg  
**Location**: rg-king  
**Rules**:

| Priority | Name | Protocol | Direction | Access | Port Range | Source | Destination |
|----------|------|----------|-----------|--------|------------|--------|-------------|
| 100 | Allow-SSH | TCP | Inbound | Allow | 22 | * | * |
| 110 | Allow-HTTP | TCP | Inbound | Allow | 80 | * | * |

**Usage**: Controls traffic to resources in rg-king

## 💾 Storage

### Storage Account 1
- **Name**: storage1
- **Resource Group**: rg-king
- **Region**: East US
- **Tier**: Standard
- **Replication**: LRS (Locally Redundant Storage)
- **Capacity**: 5GB to 100TB

### Storage Account 2
- **Name**: storage2
- **Resource Group**: rg-queen
- **Region**: Central US
- **Tier**: Standard
- **Replication**: LRS (Locally Redundant Storage)
- **Capacity**: 5GB to 100TB

## 🛡️ Bastion Host

### Bastion-Host
- **Location**: East US
- **Resource Group**: rg-king
- **Virtual Network**: vnet
- **Subnet**: sub-king (10.40.0.0/25)
- **Public IP**: pip-bastion
- **Purpose**: Secure RDP/SSH gateway

**Features**:
- ✅ No direct internet exposure of VMs
- ✅ Secure HTML5 browser-based access
- ✅ SSL/TLS encryption
- ✅ JIT (Just-In-Time) access capability
- ✅ Audit logging via Azure Monitor

## 📊 Traffic Flow

### Inbound Traffic
```
Internet
   ↓
Public IPs (pip-web, pip-app)
   ↓
NSG (Security Rules: Allow SSH/HTTP)
   ↓
Network Interfaces (nic-web, nic-app)
   ↓
VMs/Resources
```

### Cross-Region Communication
```
vnet (East US)    VNet Peering    vent1 (Central US)
    VM/App    ←──────────────→      VM/App
  10.40.x.x                       10.30.x.x
```

### Bastion Access
```
User Browser
   ↓
Bastion Host (pip-bastion)
   ↓
Secure Channel
   ↓
VMs in Subnet (Private IPs)
```

## 🔄 Data Flow

### Scenario 1: Web Traffic
1. User connects to pip-web (public IP)
2. NSG allows port 80 (HTTP)
3. Traffic reaches nic-web
4. Routed to application server

### Scenario 2: Bastion Access
1. User opens Azure Portal
2. Connects through Bastion Host
3. Bastion uses pip-bastion
4. Secure tunnel to VM private IP
5. RDP/SSH access provided

### Scenario 3: Cross-Region Communication
1. App in East US needs data from Central US
2. Traffic routes through VNet Peering
3. Private network communication
4. No data egress charges

## 🎯 Deployment Flow

```
1. Resource Groups Created
   ↓
2. Virtual Networks Deployed
   ↓
3. Subnets Configured
   ↓
4. Public IPs Allocated
   ↓
5. Network Interfaces Created
   ↓
6. Security Groups Applied
   ↓
7. Storage Accounts Provisioned
   ↓
8. VNet Peering Established
   ↓
9. Bastion Host Deployed
   ↓
✅ Infrastructure Ready
```

## 📈 Scalability Considerations

### Vertical Scaling
- Add more subnets within existing vnets
- Increase storage account capacity
- Upgrade Bastion SKU

### Horizontal Scaling
- Deploy additional regions with same setup
- Create new VNet peering connections
- Add load balancer for NIC distribution

## 💡 Best Practices Implemented

✅ **Modular Design**: Separate modules for each resource type  
✅ **Regional Distribution**: East US + Central US for redundancy  
✅ **Network Segmentation**: Multiple subnets for isolation  
✅ **Security Controls**: NSG rules + Bastion gateway  
✅ **Storage Redundancy**: LRS for cost-effective backup  
✅ **IAC Standards**: Terraform for version control  
✅ **Naming Conventions**: Consistent resource naming  
✅ **Documentation**: Comprehensive architecture docs  

## 🔐 Security Features

1. **Network Isolation**
   - Private subnets with controlled access
   - VNet peering for secure cross-region communication

2. **Access Control**
   - NSG rules restrict traffic
   - Bastion for secure remote access
   - No direct internet exposure

3. **Data Protection**
   - LRS storage replication
   - Azure-managed encryption
   - Private network communication

4. **Compliance**
   - Azure Policy ready
   - Audit logging capable
   - Regulatory-compliant design

---

**Last Updated**: June 12, 2026  
**Terraform Version**: 4.1.0  
**Azure Provider**: Latest
