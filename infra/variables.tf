variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "name" {
  type        = string
  description = "Name prefix (max 22 chars for OpenSearch compatibility)"
  default     = "ent-obs"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]*$", var.name)) && length(var.name) <= 22
    error_message = "Name must start with lowercase letter, contain only a-z, 0-9, hyphens, and be max 22 characters"
  }
}

variable "tags" {
  type        = map(string)
  description = "Common tags"
  default = {
    Environment = "demo"
    ManagedBy   = "terraform"
  }
}
