<!-- BEGIN_TF_DOCS -->
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Developed by: Cisco](https://img.shields.io/badge/Developed%20by-Cisco-blue)](https://developer.cisco.com)
[![Tests](https://github.com/terraform-cisco-modules/terraform-intersight-policies-sd-card/actions/workflows/terratest.yml/badge.svg)](https://github.com/terraform-cisco-modules/terraform-intersight-policies-sd-card/actions/workflows/terratest.yml)

# Terraform Intersight Policies - SD Card
Manages Intersight SD Card Policies

Location in GUI:
`Policies` » `Create Policy` » `SD Card`

## Easy IMM

[*Easy IMM - Comprehensive Example*](https://github.com/terraform-cisco-modules/easy-imm-comprehensive-example) - A comprehensive example for policies, pools, and profiles.

## Example

### main.tf
```hcl
module "sd_card" {
  source  = "terraform-cisco-modules/policies-sd-card/intersight"
  version = ">= 1.0.1"

  description        = "default SD Card Policy."
  enable_diagnostics = false
  enable_drivers     = false
  enable_huu         = false
  enable_os          = true
  enable_scu         = false
  name               = "default"
  organization       = "default"
}
```

### provider.tf
```hcl
terraform {
  required_providers {
    intersight = {
      source  = "CiscoDevNet/intersight"
      version = ">=1.0.32"
    }
  }
  required_version = ">=1.3.0"
}

provider "intersight" {
  apikey    = var.apikey
  endpoint  = var.endpoint
  secretkey = fileexists(var.secretkeyfile) ? file(var.secretkeyfile) : var.secretkey
}
```

### variables.tf
```hcl
variable "apikey" {
  description = "Intersight API Key."
  sensitive   = true
  type        = string
}

variable "endpoint" {
  default     = "https://intersight.com"
  description = "Intersight URL."
  type        = string
}

variable "secretkey" {
  default     = ""
  description = "Intersight Secret Key Content."
  sensitive   = true
  type        = string
}

variable "secretkeyfile" {
  default     = "blah.txt"
  description = "Intersight Secret Key File Location."
  sensitive   = true
  type        = string
}
```

## Environment Variables

### Terraform Cloud/Enterprise - Workspace Variables
- Add variable apikey with the value of [your-api-key]
- Add variable secretkey with the value of [your-secret-file-content]

### Linux and Windows
```bash
export TF_VAR_apikey="<your-api-key>"
export TF_VAR_secretkeyfile="<secret-key-file-location>"
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.3.0 |
| <a name="requirement_intersight"></a> [intersight](#requirement\_intersight) | >=1.0.32 |
## Providers

| Name | Version |
|------|---------|
| <a name="provider_intersight"></a> [intersight](#provider\_intersight) | 1.0.32 |
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apikey"></a> [apikey](#input\_apikey) | Intersight API Key. | `string` | n/a | yes |
| <a name="input_endpoint"></a> [endpoint](#input\_endpoint) | Intersight URL. | `string` | `"https://intersight.com"` | no |
| <a name="input_secretkey"></a> [secretkey](#input\_secretkey) | Intersight Secret Key. | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | Description for the Policy. | `string` | `""` | no |
| <a name="input_enable_diagnostics"></a> [enable\_diagnostics](#input\_enable\_diagnostics) | Flag to Enable the Diagnostics Utility Partition.<br>* When two cards are present in the Cisco FlexFlash controller and Operating System is chosen in the SD card policy, the configured OS partition is mirrored. If only single card is available in the Cisco FlexFlash controller, the configured OS partition is non-RAID. The utility partitions are always set as non-RAID.<br>* Note:<br>  - This policy is currently not supported on M6 servers.<br>  - You can enable up to two utility virtual drives on M5 servers, and any number of supported utility virtual drives on M4 servers.<br>  - Diagnostics is supported only for the M5 servers.<br>  - UserPartition drives can be renamed only on the M4 servers.<br>  - FlexFlash configuration is not supported on C460 M4 servers.<br>  - For the Operating System+Utility mode, the M4 servers require two FlexFlash cards, and the M5 servers require at least 1 FlexFlash + 1 FlexUtil card. | `bool` | `false` | no |
| <a name="input_enable_drivers"></a> [enable\_drivers](#input\_enable\_drivers) | Flag to Enable the Drivers Utility Partition.<br>* When two cards are present in the Cisco FlexFlash controller and Operating System is chosen in the SD card policy, the configured OS partition is mirrored. If only single card is available in the Cisco FlexFlash controller, the configured OS partition is non-RAID. The utility partitions are always set as non-RAID.<br>* Note:<br>  - This policy is currently not supported on M6 servers.<br>  - You can enable up to two utility virtual drives on M5 servers, and any number of supported utility virtual drives on M4 servers.<br>  - Diagnostics is supported only for the M5 servers.<br>  - UserPartition drives can be renamed only on the M4 servers.<br>  - FlexFlash configuration is not supported on C460 M4 servers.<br>  - For the Operating System+Utility mode, the M4 servers require two FlexFlash cards, and the M5 servers require at least 1 FlexFlash + 1 FlexUtil card. | `bool` | `false` | no |
| <a name="input_enable_huu"></a> [enable\_huu](#input\_enable\_huu) | Flag to Enable the HostUpgradeUtility Utility Partition.<br>* When two cards are present in the Cisco FlexFlash controller and Operating System is chosen in the SD card policy, the configured OS partition is mirrored. If only single card is available in the Cisco FlexFlash controller, the configured OS partition is non-RAID. The utility partitions are always set as non-RAID.<br>* Note:<br>  - This policy is currently not supported on M6 servers.<br>  - You can enable up to two utility virtual drives on M5 servers, and any number of supported utility virtual drives on M4 servers.<br>  - Diagnostics is supported only for the M5 servers.<br>  - UserPartition drives can be renamed only on the M4 servers.<br>  - FlexFlash configuration is not supported on C460 M4 servers.<br>  - For the Operating System+Utility mode, the M4 servers require two FlexFlash cards, and the M5 servers require at least 1 FlexFlash + 1 FlexUtil card. | `bool` | `false` | no |
| <a name="input_enable_os"></a> [enable\_os](#input\_enable\_os) | Flag to Enable the OperatingSystem Partition.<br>* When two cards are present in the Cisco FlexFlash controller and Operating System is chosen in the SD card policy, the configured OS partition is mirrored. If only single card is available in the Cisco FlexFlash controller, the configured OS partition is non-RAID. The utility partitions are always set as non-RAID.<br>* Note:<br>  - This policy is currently not supported on M6 servers.<br>  - You can enable up to two utility virtual drives on M5 servers, and any number of supported utility virtual drives on M4 servers.<br>  - Diagnostics is supported only for the M5 servers.<br>  - UserPartition drives can be renamed only on the M4 servers.<br>  - FlexFlash configuration is not supported on C460 M4 servers.<br>  - For the Operating System+Utility mode, the M4 servers require two FlexFlash cards, and the M5 servers require at least 1 FlexFlash + 1 FlexUtil card. | `bool` | `false` | no |
| <a name="input_enable_scu"></a> [enable\_scu](#input\_enable\_scu) | Flag to Enable the ServerConfigurationUtility Utility Partition.<br>* When two cards are present in the Cisco FlexFlash controller and Operating System is chosen in the SD card policy, the configured OS partition is mirrored. If only single card is available in the Cisco FlexFlash controller, the configured OS partition is non-RAID. The utility partitions are always set as non-RAID.<br>* Note:<br>  - This policy is currently not supported on M6 servers.<br>  - You can enable up to two utility virtual drives on M5 servers, and any number of supported utility virtual drives on M4 servers.<br>  - Diagnostics is supported only for the M5 servers.<br>  - UserPartition drives can be renamed only on the M4 servers.<br>  - FlexFlash configuration is not supported on C460 M4 servers.<br>  - For the Operating System+Utility mode, the M4 servers require two FlexFlash cards, and the M5 servers require at least 1 FlexFlash + 1 FlexUtil card. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for the Policy. | `string` | `"default"` | no |
| <a name="input_organization"></a> [organization](#input\_organization) | Intersight Organization Name to Apply Policy to.  https://intersight.com/an/settings/organizations/. | `string` | `"default"` | no |
| <a name="input_profiles"></a> [profiles](#input\_profiles) | List of Profiles to Assign to the Policy.<br>* name - Name of the Profile to Assign.<br>* object\_type - Object Type to Assign in the Profile Configuration.<br>  - server.Profile - For UCS Server Profiles.<br>  - server.ProfileTemplate - For UCS Server Profile Templates. | <pre>list(object(<br>    {<br>      name        = string<br>      object_type = optional(string, "server.Profile")<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | List of Tag Attributes to Assign to the Policy. | `list(map(string))` | `[]` | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_moid"></a> [moid](#output\_moid) | Storage SD Card Policy Managed Object ID (moid). |
## Resources

| Name | Type |
|------|------|
| [intersight_sdcard_policy.sd_card](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/resources/sdcard_policy) | resource |
| [intersight_organization_organization.org_moid](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/organization_organization) | data source |
| [intersight_server_profile.profiles](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/server_profile) | data source |
| [intersight_server_profile_template.templates](https://registry.terraform.io/providers/CiscoDevNet/intersight/latest/docs/data-sources/server_profile_template) | data source |
<!-- END_TF_DOCS -->