<!-- BEGIN_TF_DOCS -->
# Terraform Intersight Policies - SD Card
Manages Intersight SD Card Policies

Location in GUI:
`Policies` » `Create Policy` » `SD Card`

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
  secretkey = var.secretkey
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
  description = "Intersight Secret Key."
  sensitive   = true
  type        = string
}
```

## Environment Variables

### Terraform Cloud/Enterprise - Workspace Variables
- Add variable apikey with value of [your-api-key]
- Add variable secretkey with value of [your-secret-file-content]

### Linux
```bash
export TF_VAR_apikey="<your-api-key>"
export TF_VAR_secretkey=`cat <secret-key-file-location>`
```

### Windows
```bash
$env:TF_VAR_apikey="<your-api-key>"
$env:TF_VAR_secretkey="<secret-key-file-location>"
```
<!-- END_TF_DOCS -->