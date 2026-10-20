# Architecture

## Purpose

Integrate a Windows Server Active Directory domain with Microsoft Entra ID to demonstrate a hybrid identity flow and centralized cloud authentication controls.

## Logical components

| Component | Responsibility |
|---|---|
| Azure resource group | Lifecycle and organization of the workload resources |
| Virtual network and identity subnet | Private connectivity for the two Windows Server VMs |
| Network Security Group | Network-level traffic filtering associated with the identity subnet |
| Directory server | Active Directory Domain Services and DNS |
| Synchronization server | Domain-joined member server running Microsoft Entra Connect Sync |
| Azure Bastion Developer | Browser-based administrative access without VM public IP addresses |
| Microsoft Entra Connect Sync | Synchronizes selected identities from AD DS to Microsoft Entra ID using Password Hash Synchronization |
| Microsoft Entra ID | Cloud identity directory and authentication control plane |
| MFA / Conditional Access | Additional verification and policy-based access controls |

## Identity flow

1. User and group objects are managed in AD DS.
2. Microsoft Entra Connect Sync synchronizes selected directory objects to Microsoft Entra ID.
3. Password Hash Synchronization supports cloud authentication using synchronized password hashes.
4. Microsoft Entra ID applies configured authentication controls, including MFA and Conditional Access.

## Network design

The original implementation used a single virtual network and identity subnet for the directory server and synchronization server. The VMs were assigned private addresses and did not require public IP addresses. Azure Bastion Developer was used for administrative access.

For this public repository, address ranges are configurable inputs rather than copied from the original environment.
