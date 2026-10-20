# Implementation and validation record

## Azure infrastructure

- Created a dedicated resource group.
- Created a virtual network and identity subnet.
- Created and associated a Network Security Group.
- Deployed two Windows Server 2022 virtual machines in the identity subnet.
- Configured private addressing and no public IP addresses on the VMs.
- Used Azure Bastion Developer for administrative access.

## Hybrid identity

- Configured the directory server with Active Directory Domain Services and DNS.
- Joined the synchronization server to the AD DS domain.
- Created directory user accounts and a security group.
- Installed Microsoft Entra Connect Sync on the dedicated member server.
- Configured Password Hash Synchronization.
- Confirmed that users created in AD DS appeared in Microsoft Entra ID.

## Authentication controls

- Tested multifactor authentication.
- Tested a Conditional Access policy targeting a limited test scope and Microsoft administrative/cloud resources.
- The policy was tested during implementation; this repository does not assert that the policy remains active today.
- Policy screenshots were not retained, so the exact final policy state is not independently evidenced here.

## Lifecycle

The environment was deleted after validation to prevent ongoing Azure charges. As a result, the Terraform files are a reconstructed infrastructure definition, not an export from the deleted Azure deployment.
