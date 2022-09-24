module "sd_card" {
  source  = "terraform-cisco-modules/policies-sd-card/intersight"
  version = ">= 1.0.1"

  description      = "default SD Card Policy."
      enable_diagnostics = false
      enable_drivers     = false
      enable_huu         = false
      enable_os          = true
      enable_scu         = false
  name         = "default"
  organization = "default"
}
