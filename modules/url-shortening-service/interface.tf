variable "region" {
  description = "The AWS provider region to be used as main deployment environment."
}

variable "environment" {
  type        = string
  description = "The environment that the resource is being created into."
}

variable "name" {
  type        = string
  description = "The name to be used to identify the service."
}

variable "alb_sg_id" {
  type        = list
  description = "the security group list to be included in the application load balancer."
  default     = null
}

variable "alb_subnets" {
  type        = list
  description = "the subnets to be included in the application load balancer."
  default     = null
}

variable "alb_internal" {
  type        = bool
  description = "the subnets to be included in the application load balancer."
  default     = true
}

variable "ecs_cluster" {
  type        = string
  description = "The ECS cluster being used by the ECS service."
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID to assign resources to."
}

variable "front_end_image" {
  type        = string
  description = "The docker container image to be used for Django (Front-End) ECS task."
  default     = ""
}

variable "redis_image" {
  type        = string
  description = "The docker container image to be used for Redis (caching) ECS task."
  default     = ""
}

variable "db_image" {
  type        = string
  description = "The docker container image to be used for Redis (database) ECS task."
  default     = ""
}

variable "short_url_domain" {
  type        = string
  description = "The short URL for the domain that is going to host the service (e.g: 'mydomain.net')"
}

output "alb" {
  value = aws_lb.url_shortener_alb
}
