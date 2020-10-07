module "url_shortener_task_db" {
  source         = "../ecs_task"
  environment    = var.environment
  region         = var.region
  task_name      = "${var.name}-db"
  task_image     = var.db_image
  container_port = 5432
  cpu            = 512
  memory         = 1024
  db_password    = var.consul_url_shortener_db_password # Ideally this should be stored in secrets manager solutions (e.g: AWS Secrets Manager, Hashicorp Consul) and stored in ECS environment variables for the service.
  db_username    = var.consul_url_shortener_db_username # Ideally this should be stored in secrets manager solutions (e.g: AWS Secrets Manager, Hashicorp Consul) and stored in ECS environment variables for the service.
}

resource "aws_ecs_service" "url_shortener_service" {
  cluster                           = var.cluster
  name                              = var.name
  task_definition                   = module.url_shortener_task_db.task_db_arn
  desired_count                     = 1
  health_check_grace_period_seconds = 2
  launch_type                       = "FARGATE"

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "${var.name}-db"
    container_port   = 5432
  }

  network_configuration {
    assign_public_ip = false
    security_groups  = [var.security_groups]
    subnets          = var.alb_subnets
  }
}
