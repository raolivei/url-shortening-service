resource "aws_ecs_task_definition" "url_shortener_db" {
  family = "service"
  # task_role_arn 
  # execution_role_arn 
  # image = "longshn/postgres:13.0"
  container_definitions = "${data.template_file.container_definition.rendered}"

  tags = {
    TFManaged   = true
    Environment = var.environment
    Project     = "unity_url_shortener"
  }
}

data "template_file" "container_definition" {
  template = file("${path.module}/templates/postgres-service.json.tpl")

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
