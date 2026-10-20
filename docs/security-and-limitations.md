# Security considerations and limitations

## Security decisions

- VM administrative access used Azure Bastion Developer.
- The Windows VMs had no public IP addresses.
- No rule should expose RDP (TCP/3389) to `Any` or the public internet.
- Credentials are not stored in the repository.
- Private address ranges and deployment location are provided as inputs.
- MFA and Conditional Access were tested, but no claim is made that the test policy remains enabled in the tenant.

## Important limitations

- The original Azure environment and its resource state have been deleted.
- This Terraform configuration is reconstructed from the implementation guide and confirmed project details.
- The exact deployed VM size, image version, Azure region, and all portal-specific settings cannot be recovered with certainty from the deleted deployment.
- Terraform provisions Azure infrastructure; it does not by itself configure AD DS forest promotion, Windows domain membership, Entra Connect Sync, or Microsoft Entra tenant policies.
- The sample internal domain is a configurable variable. For production hybrid identity, use a suitable verified/routable UPN suffix and validate domain/UPN design against current Microsoft guidance.
- Azure Bastion Developer was used in the original implementation but is not provisioned by the base Terraform files in this repository. Its deployment requirements and provider support should be reviewed separately before rebuilding.

## Before any deployment

1. Review all variables and the selected Azure region.
2. Confirm image and VM-size availability and cost.
3. Securely supply the administrator password.
4. Run `terraform plan` and inspect every proposed resource.
5. Confirm that no public IP or unrestricted RDP rule is being created.
6. Destroy resources when no longer required.
