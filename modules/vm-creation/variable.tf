variable "resource_group_name" {
  type    = string
}

variable "location" {
  type    = string
}

variable "vnet_name" {
  type    = string
}

variable "vnet_rg" {
  type    = string
}

variable "subnet_name" {
  type    = string
}

variable "vm_name" {
  type    = string
}

variable "os_disk_type" {
  type    = string
}

variable "admin_username" {
  type    = string
}

variable "vm_size" {
  type    = string
}

variable "image_publisher" {
  type    = string
}

variable "disk_sizes" {
  type    = list(number)
}

variable "disk_count" {
  type    = number
}

variable "image_offer" {
  type    = string
}

variable "image_sku" {
  type    = string
}