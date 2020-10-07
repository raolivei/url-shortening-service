variable "region" {
  description = "The AWS provider region to be used as main deployment environment."
}

variable "environment" {
  type        = string
  description = "The environment that the resource is being created into."
}

variable "cluster" {
  type        = string
  description = "The ECS cluster to assign the service to."
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID to assign resources to."
}

variable "name" {
  type        = string
  description = "The name for the ECS service"
}

variable "db_image" {
  type        = string
  description = "The docker container image to be used for Redis (databse) ECS task."
}

variable "target_group_arn" {
  type        = string
  description = "The Target Group ARN to be attached to the load balancer."
}

variable "security_groups" {
  type        = string
  description = "The security group list to be included in the ecs service network configuration."
}

variable "alb_subnets" {
  type        = list
  description = "the subnets to be included in the application load balancer."
  default     = null
}

variable "consul_url_shortener_db_username" {
  type        = string
  description = "The db username stored in a secrets manager solution to be passed to the ECS db task."
  default     = "username"
}

variable "consul_url_shortener_db_password" {
  type        = string
  description = "The db password stored in a secrets manager solution to be passed to the ECS db task."
  default     = "password"
}
