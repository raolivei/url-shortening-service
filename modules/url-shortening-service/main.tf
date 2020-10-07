module "url_shortener_service" {
  source           = "../ecs_service"
  environment      = var.environment
  region           = var.region
  cluster          = var.ecs_cluster
  vpc_id           = var.vpc_id
  name             = var.name
  db_image         = var.db_image
  target_group_arn = aws_lb_target_group.url_shortener_alb_tg.arn
  security_groups  = aws_security_group.url_shortener_alb_sg.id
  alb_subnets      = var.alb_subnets
}

resource "aws_lb" "url_shortener_alb" {
  name               = "${var.name}-alb"
  internal           = var.alb_internal
  load_balancer_type = "application"
  security_groups    = [aws_security_group.url_shortener_alb_sg.id]
  subnets            = var.alb_subnets # Optional

  enable_deletion_protection = true

  tags = {
    TFManaged   = true
    Environment = var.environment
    Project     = "unity_url_shortener"
  }
}

resource "aws_lb_target_group" "url_shortener_alb_tg" {
  name        = "${var.name}-alb-tg"
  port        = 443
  protocol    = "HTTPS"
  vpc_id      = var.vpc_id
  target_type = "ip"
  depends_on = [
    aws_lb.url_shortener_alb
  ]
}

resource "aws_lb_listener" "url_shortener_alb_listener" {
  load_balancer_arn = aws_lb.url_shortener_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.url_shortener_alb_cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.url_shortener_alb_tg.arn
  }
}

resource "aws_security_group" "url_shortener_alb_sg" {
  name        = "${var.name}-alb-sg"
  description = "Allow https traffic to the load balancer"
  vpc_id      = var.vpc_id

  ingress {
    description = "TLS from public"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    TFManaged   = true
    Environment = var.environment
    Project     = "unity_url_shortener"
  }
}

resource "aws_acm_certificate" "url_shortener_alb_cert" {
  domain_name       = var.short_url_domain
  validation_method = "DNS"

  tags = {
    TFManaged   = true
    Environment = var.environment
    Project     = "unity_url_shortener"
  }

  lifecycle {
    create_before_destroy = true
  }
}
