data "vault_ldap_static_credentials" "vm_builder" {
  mount     = "ldap"
  role_name = "vm_builder"
}

module "vm" {
  source  = "app.terraform.io/cloudbrokeraz/virtual-machine/vsphere"
  version = "0.0.1"

  template          = var.vsphere_template_name
  datacenter        = var.site
  cluster           = var.environment
  resource_pool     = var.tier
  primary_datastore = var.storage_profile
  folder_path       = var.folder_path
  hostname          = var.hostname
  num_cpus          = var.num_cpus
  memory            = var.memory
  disk_0_size       = var.disk_0_size
  admin_password    = var.admin_password
  workgroup         = var.workgroup

  networks = {
    "seg-general" = "dhcp"
  }
  gateway         = var.gateway
  dns_server_list = var.dns_server_list
  dns_suffix_list = var.dns_suffix_list

  tags = {
    environment      = "prod"
    site             = "sydney"
    backup_policy    = "daily"
    tier             = "management"
    storage_profile  = "standard"
    security_profile = "web-server"
  }
}
