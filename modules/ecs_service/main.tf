resource "aws_ecs_service" "url_shortener_service" {
  name            = "url-shortener"
  cluster         = var.cluster
  task_definition = aws_ecs_task_definition.url_shortener_service.arn
  desired_count   = 1
  iam_role        = aws_iam_role.url_shortener.arn

  load_balancer {
    target_group_arn = aws_lb_target_group.url_shortener_tg.arn
    container_name   = "url_shortener_service_ecs_task"
    container_port   = 8080
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  }
}

resource "aws_ecs_task_definition" "url_shortener_service" {
  family                = "service"
  container_definitions = file("${path.module}/ecs_task/service.json")
}

resource "aws_lb_target_group" "url_shortener_tg" {
  name     = "url-shortener-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}
