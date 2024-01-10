resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.vnet_rg
}

data "azurerm_subnet" "private-subnet" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_virtual_network.vnet.resource_group_name
}

resource "azurerm_public_ip" "example" {
  name                = "example-public-ip"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "main" {
  name                = "${var.vm_name}-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.private-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example.id
  }
}

data "azurerm_key_vault_secret" "admin_password" {
  name         = "adminpass"
  key_vault_id = "/subscriptions/fee7b7ee-0390-4383-a392-3a90b8e633cb/resourceGroups/ankita-test/providers/Microsoft.KeyVault/vaults/linuxcredential"
}

resource "azurerm_virtual_machine" "example" {
  name                  = var.vm_name
  location              = azurerm_resource_group.example.location
  resource_group_name   = azurerm_resource_group.example.name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = var.vm_size
  delete_os_disk_on_termination = true
  storage_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = "latest"
  }
  storage_os_disk {
    name              = "${var.vm_name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = var.os_disk_type
  }
  os_profile {
    computer_name  = var.vm_name
    admin_username = var.admin_username
    admin_password = data.azurerm_key_vault_secret.admin_password.value
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}
resource "azurerm_managed_disk" "example" {
  count               = var.disk_count
  name                = "${var.vm_name}-disk${count.index + 1}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  storage_account_type = "Standard_LRS"
  create_option       = "Empty"
  disk_size_gb        = var.disk_sizes[count.index]
}
resource "azurerm_virtual_machine_data_disk_attachment" "example" {
  count               = var.disk_count
  managed_disk_id     = azurerm_managed_disk.example[count.index].id
  virtual_machine_id  = azurerm_virtual_machine.example.id
  lun                 = count.index + 1
  caching             = "ReadWrite"
}