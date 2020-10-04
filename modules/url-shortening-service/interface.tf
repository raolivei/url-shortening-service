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
