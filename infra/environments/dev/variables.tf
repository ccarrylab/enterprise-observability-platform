variable "name" {
description = "Project name"
type = string
default = "enterprise-obs-dev"
}

variable "environment" {
description = "Environment name"
type = string
default = "dev"
}

variable "eks_version" {
description = "EKS Kubernetes version"
type = string
default = "1.29"
}

variable "node_instance_types" {
description = "EC2 instance types"
type = list(string)
default = ["t3.medium"]
}

variable "node_desired_size" {
description = "Desired node count"
type = number
default = 2
}

variable "node_min_size" {
description = "Min node count"
type = number
default = 2
}

variable "node_max_size" {
description = "Max node count"
type = number
default = 4
}

variable "tags" {
description = "Tags to apply"
type = map(string)
default = {
Environment = "dev"
CostCenter = "engineering"
Team = "platform"
}
}
