variable "region" {
  description = "The AWS provider region to be used as main deployment environment."
}

variable "environment" {
  type        = string
  description = "The environment that the resource is being created into."
}

variable "task_name" {
  type        = string
  description = "The name for the ECS service."
}

variable "task_image" {
  type        = string
  description = "The docker container image to be passed to the service."
}

variable "container_port" {
  type        = number
  description = "The docker container port to be exposed to the service."
}

variable "cpu" {
  type        = number
  description = "The number of cpu units reserved for the container."
}

variable "memory" {
  type        = number
  description = "The memory size to assign to the ECS service."
}

variable "db_password" {
  type        = string
  description = "The database password."
}

variable "db_username" {
  type        = string
  description = "The database username."
}

output "task_db_arn" {
  value = aws_ecs_task_definition.url_shortener_db.arn
}
