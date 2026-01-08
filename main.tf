module "vm" {
  source       = "./modules/vm"
  vm_name      = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone
  image        = "debian-cloud/debian-11"
  network      = "default"
}
