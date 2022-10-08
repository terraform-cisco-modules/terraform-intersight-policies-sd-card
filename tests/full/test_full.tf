module "main" {
  source             = "../.."
  description        = "${var.name} SD Card Policy."
  enable_diagnostics = false
  enable_drivers     = false
  enable_huu         = false
  enable_os          = true
  enable_scu         = false
  name               = var.name
  organization       = "terratest"
}
