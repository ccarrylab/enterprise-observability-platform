variable "name" {
  type        = string
  description = "EKS name prefix"
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

variable "public_subnet_ids" {
  type = list(string)
}

variable "account_id" {
  type = string
}

variable "eks_version" {
  type    = string
  default = "1.29"
}

variable "endpoint_public_access" {
  type    = bool
  default = true
}

variable "public_access_cidrs" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "node_instance_types" {
  description = "EKS node instance types"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_min_size" {
  description = "Min EKS nodes"
  type        = number
  default     = 1
}

variable "node_desired_size" {
  description = "Desired EKS nodes"
  type        = number
  default     = 2
}

variable "node_max_size" {
  description = "Max EKS nodes"
  type        = number
  default     = 5
}
