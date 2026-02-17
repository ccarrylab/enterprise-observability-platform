variable "name" {
  type        = string
  description = "Name prefix for ECR repository"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to ECR repository"
  default     = {}
}
