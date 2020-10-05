variable "aws_provider" {
  description = "The AWS provider region to be used as main deployment environment."
}

variable "vpc_id" {
  description = "The VPC ID to be used in the ECS service and ALB target group."
}

variable "short_url_domain" {
  description = "The DNS domain registered for the URL shortening service."
}

variable "existing_ecs_cluster" {
  description = "The ECS cluster to create the ECS service upon. If not specified, a new cluster will be created."
  default     = null
}
