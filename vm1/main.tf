module "vm-creation" {
    source = "../modules/vm-creation"
    resource_group_name = var.resource_group_name
    location = var.location
    vnet_name = var.vnet_name
    vnet_rg = var.vnet_rg
    subnet_name = var.subnet_name
    vm_name = var.vm_name
    os_disk_type = var.os_disk_type
    admin_username = var.admin_username
    vm_size = var.vm_size
    image_publisher = var.image_publisher
    disk_sizes = var.disk_sizes
    image_offer = var.image_offer
    image_sku = var.image_sku
    disk_count= var.disk_count
}