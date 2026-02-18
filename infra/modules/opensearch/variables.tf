variable "name" {
  type        = string
  description = "Opensearch name"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "allowed_cidr" {
  type = string
}

variable "account_id" {
  type = string
}
