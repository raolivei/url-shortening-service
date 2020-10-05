variable "cluster" {
  type        = string
  description = "The ECS cluster to assign the service to."
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID to assign resources to."
}
