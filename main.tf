#____________________________________________________________
#
# Intersight Organization Data Source
# GUI Location: Settings > Settings > Organizations > {Name}
#____________________________________________________________

data "intersight_organization_organization" "org_moid" {
  for_each = {
    for v in [var.organization] : v => v if length(
      regexall("[[:xdigit:]]{24}", var.organization)
    ) == 0
  }
  name = each.value
}

#____________________________________________________________
#
# Intersight UCS Server Profile(s) Data Source
# GUI Location: Profiles > UCS Server Profiles > {Name}
#____________________________________________________________

data "intersight_server_profile" "profiles" {
  for_each = { for v in var.profiles : v.name => v if v.object_type == "server.Profile" }
  name     = each.value.name
}

#__________________________________________________________________
#
# Intersight UCS Server Profile Template(s) Data Source
# GUI Location: Templates > UCS Server Profile Templates > {Name}
#__________________________________________________________________

data "intersight_server_profile_template" "templates" {
  for_each = { for v in var.profiles : v.name => v if v.object_type == "server.ProfileTemplate" }
  name     = each.value.name
}

#__________________________________________________________________
#
# Intersight SD Card Policy
# GUI Location: Policies > Create Policy > SD Card
#__________________________________________________________________

resource "intersight_sdcard_policy" "sd_card" {
  depends_on = [
    data.intersight_server_profile.profiles,
    data.intersight_server_profile_template.templates,
    data.intersight_organization_organization.org_moid
  ]
  description = var.description != "" ? var.description : "${var.name} SD Card Policy."
  name        = var.name
  organization {
    moid = length(
      regexall("[[:xdigit:]]{24}", var.organization)
      ) > 0 ? var.organization : data.intersight_organization_organization.org_moid[
      var.organization].results[0
    ].moid
    object_type = "organization.Organization"
  }
  dynamic "partitions" {
    for_each = { for v in [var.enable_os] : v => v if var.enable_os == true }
    content {
      type        = "OS"
      object_type = "sdcard.Partition"
      virtual_drives {
        additional_properties = jsonencode({ Name = "Hypervisor" })
        enable                = var.enable_os
        object_type           = "sdcard.OperatingSystem"
      }
    }
  }
  dynamic "partitions" {
    for_each = {
      for v in [var.enable_diagnostics] : v => v if length(
        regexall(true, var.enable_diagnostics)) > 0 || length(
        regexall(true, var.enable_drivers)) > 0 || length(
        regexall(true, var.enable_huu)) > 0 || length(
      regexall(true, var.enable_scu)) > 0
    }
    content {
      type        = "Utility"
      object_type = "sdcard.Partition"
      virtual_drives {
        enable      = var.enable_diagnostics
        object_type = "sdcard.Diagnostics"
      }
      virtual_drives {
        enable      = var.enable_drivers
        object_type = "sdcard.Drivers"
      }
      virtual_drives {
        enable      = var.enable_huu
        object_type = "sdcard.HostUpgradeUtility"
      }
      virtual_drives {
        enable      = var.enable_scu
        object_type = "sdcard.ServerConfigurationUtility"
      }
    }
  }
  dynamic "profiles" {
    for_each = { for v in var.profiles : v.name => v }
    content {
      moid = length(regexall("server.ProfileTemplate", profiles.value.object_type)
        ) > 0 ? data.intersight_server_profile_template.templates[profiles.value.name].results[0
      ].moid : data.intersight_server_profile.profiles[profiles.value.name].results[0].moid
      object_type = profiles.value.object_type
    }
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}
