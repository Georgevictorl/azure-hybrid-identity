# Terraform — Azure infrastructure foundation

This code reconstructs the Azure infrastructure foundation for the hybrid identity architecture. It provisions the resource group, virtual network, subnet, NSG, two NICs, and two Windows Server VMs.

## Not provisioned by this code

- Azure Bastion Developer
- AD DS forest promotion and DNS role configuration
- Domain join of the synchronization server
- Microsoft Entra Connect Sync installation and configuration
- Microsoft Entra tenant users, MFA, or Conditional Access policies

Those steps require separate configuration and are described in the documentation. The base Terraform does not create public IP addresses or custom inbound RDP rules.

## Inputs and credentials

The network CIDRs are variables to avoid copying the original deployment's addressing. Pick private, non-overlapping ranges. The administrator username/password are required inputs. Keep secrets out of source control.

PowerShell example:

```powershell
$env:TF_VAR_admin_username = "your-admin-username"
$env:TF_VAR_admin_password = "your-strong-unique-password"
terraform init
terraform validate
terraform plan
```

Bash example:

```bash
export TF_VAR_admin_username='your-admin-username'
export TF_VAR_admin_password='your-strong-unique-password'
terraform init
terraform validate
terraform plan
```

## Caution

Running `terraform apply` creates billable resources. The configuration is a reconstruction, not a recovered Terraform state. Review `terraform plan`, image availability, VM size, and regional pricing before deployment.
