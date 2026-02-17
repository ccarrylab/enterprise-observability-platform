variable "name" { type = string }
variable "vpc_id" { type = string }
variable "private_subnet_ids" { type = list(string) }
variable "allowed_cidr" { type = string }
variable "account_id" { type = string }
variable "tags" { type = map(string) }
