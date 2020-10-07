resource "aws_ecs_task_definition" "url_shortener_db" {
  family                   = var.task_name
  task_role_arn            = aws_iam_role.url_shortening_task_role.arn
  execution_role_arn       = aws_iam_role.url_shortening_execution_role.arn
  container_definitions    = data.template_file.container_definition.rendered
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory

  tags = {
    TFManaged   = true
    Environment = var.environment
    Project     = "unity_url_shortener"
  }
}

data "template_file" "container_definition" {
  template = file("${path.module}/templates/redis-service.json.tpl")

  vars = {
    region         = var.region
    environment    = var.environment
    task_image     = var.task_image
    task_name      = var.task_name
    cpu            = var.cpu
    memory         = var.memory
    container_port = var.container_port
    db_password    = var.db_password
    db_username    = var.db_username
  }
}
