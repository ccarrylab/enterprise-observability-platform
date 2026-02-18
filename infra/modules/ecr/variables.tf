variable "name" {
  type        = string
  description = "Module name prefix"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "tags" {
  type    = map(string)
  default = {}
}
