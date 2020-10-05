variable "env" {
  type        = string
  description = "The environment that the resource is being created into"
  default     = "production"
}

variable "alb_name" {
  type        = string
  description = "The application load balancer name."
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
  description = "The VPC ID to assign the ECS task to."
}
