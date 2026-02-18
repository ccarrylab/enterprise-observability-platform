variable "name"                   { type = string }
variable "vpc_id"                 { type = string }
variable "private_subnet_ids"     { type = list(string) }
variable "public_subnet_ids"      { type = list(string) }
variable "eks_version"            { type = string       default = "1.29" }
variable "node_instance_types"    { type = list(string) default = ["t3.medium"] }
variable "node_desired_size"      { type = number       default = 2 }
variable "node_min_size"          { type = number       default = 2 }
variable "node_max_size"          { type = number       default = 4 }
variable "endpoint_public_access" { type = bool         default = true }
variable "public_access_cidrs"    { type = list(string) default = ["0.0.0.0/0"] }
variable "tags"                   { type = map(string)  default = {} }
