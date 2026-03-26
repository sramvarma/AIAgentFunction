# variables.tf

variable "resource_group_name" {
  description = "rgramvar"
  type        = string
  default     = "rgramvar"
}

variable "location" {
  description = "west europe"
  type        = string
  default     = "West Europe"
}

variable "storage_account_name" {
  description = "storageaccountramvar"
  type        = string
  default     = "storageaccountramvar"
}

variable "app_service_plan_name" {
  description = "asramvar"
  type        = string
  default     = "asramvar"
}

variable "function_app_name" {
  description = "aiagentfaramvar"
  type        = string
  default     = "aiagentfaramvar"
}