variable "existing_ecs_cluster_arn" {
  type        = string
  description = "Specify the ECS cluster ARN, if an existing ECS cluster is present"
}

output "ecs_cluster_id" {
  value = aws_ecs_cluster.production.0.id
}
