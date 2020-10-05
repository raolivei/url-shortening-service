resource "aws_ecs_cluster" "production" {
  count = var.existing_ecs_cluster_arn == null ? 1 : 0
  name  = "production"
}
