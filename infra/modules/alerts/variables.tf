variable "name" {
  type        = string
  description = "Module name prefix"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "tags" {
  type = map(string)
  default = {}
}

variable "opensearch_name" {
  type = string
}

variable "account_id" {
  type = string
}
