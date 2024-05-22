variable "rgname" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location/region where the resource group will be created"
  type        = string
}

variable "env" {
  description = "The environment for the resource group"
  type        = string
}

variable "batch" {
  description = "The environment for the resource group"
  type        = string
}

variable "address_space_list" {
  type = list(string)
}

variable "web_subnets_cidr" {
  type = list(string)
}

variable "app_subnets_cidr" {
  type = list(string)
}

variable "db_subnets_cidr" {
  type = list(string)
}

variable "containername" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "dns_zone" {
  type = string
}

variable "deploy_sub_id" {
  type = string
}

variable "prod_sub_id" {
  type = string
}
